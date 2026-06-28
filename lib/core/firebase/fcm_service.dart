import 'dart:async';
import 'dart:io';

import 'package:attendance_tracker/core/error/error_reporter.dart';
import 'package:attendance_tracker/core/logging/app_logger.dart';
import 'package:attendance_tracker/core/firebase/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
}

class FcmService {
  static final FcmService _instance = FcmService._();
  factory FcmService() => _instance;

  FcmService._();

  static const _tokenMaxAttempts = 3;
  static const _tokenRetryDelay = Duration(seconds: 2);
  static const _topicOperationTimeout = Duration(seconds: 5);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  final _notificationService = NotificationService();
  final Set<String> _pendingTopicSubscriptions = {};
  bool _tokenRefreshListenerAttached = false;

  String? _fcmToken;
  String? get token => _fcmToken;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    _attachTokenRefreshListener();

    await _notificationService.initialize();
    await requestPermission();

    _handleInitialMessage();
    _handleForegroundMessage();
    _initialized = true;
  }

  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger().info(
      'Notification permission : ${settings.authorizationStatus}',
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      await _initFcmToken();
    }
  }

  Future<void> _initFcmToken() async {
    try {
      if (Platform.isIOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          await _getFcmToken();
        } else {
          await Future.delayed(const Duration(seconds: 2));
          apnsToken = await _firebaseMessaging.getAPNSToken();
          if (apnsToken != null) await _getFcmToken();
        }
      } else {
        await _getFcmToken();
      }
    } catch (e, s) {
      _handleFcmTokenFailure(e, s);
    }
  }

  Future<void> _getFcmToken() async {
    for (var attempt = 1; attempt <= _tokenMaxAttempts; attempt++) {
      try {
        _fcmToken = await _firebaseMessaging.getToken();
        AppLogger().info('FCM Token : $_fcmToken');
        await _flushPendingTopicSubscriptions();
        return;
      } on FirebaseException catch (e, s) {
        final isLastAttempt = attempt == _tokenMaxAttempts;
        if (_isTransientFcmError(e) && !isLastAttempt) {
          AppLogger().warning(
            'FCM token unavailable (attempt $attempt/$_tokenMaxAttempts), '
            'retrying in ${_tokenRetryDelay.inSeconds}s...',
          );
          await Future.delayed(_tokenRetryDelay);
          continue;
        }
        _handleFcmTokenFailure(e, s);
        return;
      }
    }
  }

  bool _isTransientFcmError(FirebaseException exception) {
    final message = exception.message?.toUpperCase() ?? '';
    return message.contains('SERVICE_NOT_AVAILABLE') ||
        message.contains('INTERNAL_SERVER_ERROR') ||
        message.contains('TIMEOUT');
  }

  bool _isTransientFcmFailure(Object error) {
    if (error is TimeoutException) {
      return true;
    }
    if (error is FirebaseException) {
      return _isTransientFcmError(error);
    }
    final message = error.toString().toUpperCase();
    return message.contains('SERVICE_NOT_AVAILABLE') ||
        message.contains('INTERNAL_SERVER_ERROR') ||
        message.contains('TIMEOUT');
  }

  void _handleFcmTokenFailure(Object error, StackTrace stackTrace) {
    if (error is FirebaseException && _isTransientFcmError(error)) {
      AppLogger().warning(
        'FCM token unavailable — push notifications may not work on this '
        'device/emulator until Google Play Services is ready.',
      );
      return;
    }

    AppLogger().error('Error initializing FCM: $error');
    ErrorReporter().reportException(error, stackTrace);
  }

  void listenTokenRefresh(void Function(String) onTokenRefresh) {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _fcmToken = token;
      onTokenRefresh(token);
    });
  }

  void _attachTokenRefreshListener() {
    if (_tokenRefreshListenerAttached) {
      return;
    }
    _tokenRefreshListenerAttached = true;
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      _fcmToken = token;
      AppLogger().info('FCM token refreshed');
      await _flushPendingTopicSubscriptions();
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging
          .subscribeToTopic(topic)
          .timeout(_topicOperationTimeout);
      _pendingTopicSubscriptions.remove(topic);
    } catch (e, s) {
      if (_isTransientFcmFailure(e)) {
        _pendingTopicSubscriptions.add(topic);
        AppLogger().warning(
          'Deferred topic subscription for $topic until FCM is available.',
        );
        return;
      }
      AppLogger().error('Failed to subscribe to topic $topic: $e');
      ErrorReporter().reportException(e, s);
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    _pendingTopicSubscriptions.remove(topic);
    try {
      await _firebaseMessaging
          .unsubscribeFromTopic(topic)
          .timeout(_topicOperationTimeout);
    } catch (e, s) {
      if (_isTransientFcmFailure(e)) {
        AppLogger().warning(
          'Skipped unsubscribe from $topic — FCM unavailable on this device.',
        );
        return;
      }
      AppLogger().error('Failed to unsubscribe from topic $topic: $e');
      ErrorReporter().reportException(e, s);
    }
  }

  Future<void> _flushPendingTopicSubscriptions() async {
    if (_fcmToken == null || _pendingTopicSubscriptions.isEmpty) {
      return;
    }

    final topics = _pendingTopicSubscriptions.toList();
    for (final topic in topics) {
      await subscribeToTopic(topic);
    }
  }

  void _handleInitialMessage() {
    AppLogger().info('Handling initial message');
    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) _notificationService.handleInitialMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      _notificationService.handleInitialMessage,
    );
  }

  void _handleForegroundMessage() {
    AppLogger().info('Handling foreground message');
    FirebaseMessaging.onMessage.listen(
      _notificationService.handleForegroundMessage,
    );
  }
}
