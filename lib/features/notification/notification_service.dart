import 'dart:io';

import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_routes.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings(
      '@mipmap/ic_launcher'
    );
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

   await _flutterLocalNotificationsPlugin.initialize(
      settings: InitializationSettings(android: android, iOS: darwin),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    final lauchDetails = !kIsWeb && Platform.isLinux
        ? null 
        : await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (lauchDetails?.didNotificationLaunchApp ?? false) {
      _onLocalNotificationTap(lauchDetails!.notificationResponse!);
    }
  }

  void handleForegroundMessage(RemoteMessage message) {
    final notification = _mapToNotification(message);
    if(notification == null) return;
    _showLocalNotification(notification);
  }

  void handleInitialMessage(RemoteMessage message) {
    final notification = _mapToNotification(message);
    if(notification == null) return;
    _navigateToUrl(notification.url);
  }

  Future<void> _showLocalNotification(Notification notification) async {
    final androidDetails = AndroidNotificationDetails(
      'default_channel_id', 
      'Default Channel',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.max,
      styleInformation: BigTextStyleInformation(notification.body),
    );

    await _flutterLocalNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(),
      ),
      payload: notification.url,
    );
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    final url = response.payload;
    if(url == null || url.isEmpty) return;
    _navigateToUrl(url);
  }

  void _navigateToUrl(String url) {
    final route = _normalizeRoute(url);
    if (route == null) return;

    final appRouter = serviceLocator.get<AppRouter>();
    final authState = serviceLocator.get<AuthBloc>().state;

    if(authState is Authenticated) {
      appRouter.router.push(route);
    } else {
      appRouter.deeplink = route;
      appRouter.router.go(AuthRoutes.login);
    }
  }

  String? _normalizeRoute(String url) {
    if (url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) {
      AppLogger().warning('Invalid notification url: $url');
      return null;
    }

    if (!uri.hasScheme) {
      if (url.startsWith('/')) {
        return url;
      }
      return '/$url';
    }

    final query = uri.hasQuery ? '?${uri.query}' : '';
    final fragment = uri.hasFragment ? '#${uri.fragment}' : '';
    final route = '${uri.path}$query$fragment';

    if (route.isEmpty || route == '?') {
      AppLogger().warning('Notification url has no route path: $url');
      return null;
    }

    return route;
  }

  Notification? _mapToNotification(RemoteMessage message) {
    try {
      final data = message.data;
      return Notification(
        id: data['id'] ?? '',
        type: _parseType(data['type']),
        title: message.notification?.title ?? data['title'] ?? '',
        body: message.notification?.body ?? data['body'] ?? '',
        image: data['image'] ?? '',
        url: data['url'] ?? '',
      );
    } catch (e, s) {
      AppLogger().error('Error mapping notification: $e');
      ErrorReporter().reportException(e, s);
      return null;
    }
  }

  NotificationType _parseType(String? type) {
    return NotificationType.values.firstWhere((e) => e.name == type,
    orElse: () => NotificationType.announcement,
    );
  }
}