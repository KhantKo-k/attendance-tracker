import 'dart:io';

import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:app_starter_kit_bloc/core/firebase/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();
}

class FcmService {
  static final FcmService _instance = FcmService._();
  factory FcmService() => _instance;

  FcmService._();

  static const _tokenMaxAttempts = 3;
  static const _tokenRetryDelay = Duration(seconds: 2);

  late final FirebaseMessaging _firebaseMessaging;
  final _notificationService = NotificationService();

  String? _fcmToken;
  String? get token => _fcmToken;

  Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    _firebaseMessaging = FirebaseMessaging.instance;

    await _initFcmToken();

    await _notificationService.initialize();

    _handleInitialMessage();
    _handleForegroundMessage();
    _handleBackgroundMessage();
  }

  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger().info(
      "Notification permission : ${settings.authorizationStatus}",
    );

    if (settings.authorizationStatus ==
            AuthorizationStatus.authorized ||
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
        AppLogger().info("FCM Token : $_fcmToken");
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

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void _handleInitialMessage() {
    AppLogger().info('Handling initial message');
    FirebaseMessaging.instance.getInitialMessage().then((message) {
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

  void _handleBackgroundMessage() {
    AppLogger().info('Handling background message');
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }
}
