import 'dart:io';

import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:app_starter_kit_bloc/features/notification/notification_service.dart';
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

  late final FirebaseMessaging _firebaseMessaging;
  final _notificationService = NotificationService();

  String? _fcmToken;
  String? get token => _fcmToken;

  Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    _firebaseMessaging = FirebaseMessaging.instance;

   
    try {
      await _initFcmToken();
    } catch (e, s) {
      AppLogger().error('Error initializing FCM: $e');
      ErrorReporter().reportException(e, s);
    }

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
        settings.authorizationStatus ==
            AuthorizationStatus.provisional) {
      await _initFcmToken();
    }
  }

  Future<void> _initFcmToken() async {
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
  }

  Future<void> _getFcmToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
    AppLogger().info("FCM Token : $_fcmToken");
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
