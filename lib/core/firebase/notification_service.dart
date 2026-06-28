import 'package:attendance_tracker/core/di/service_locator.dart';
import 'package:attendance_tracker/core/firebase/push_notification_navigator.dart';
import 'package:attendance_tracker/core/logging/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onLocalNotificationTapped,
    );
  }

  Future<void> handleInitialMessage(RemoteMessage message) async {
    AppLogger().info('Opened from notification: ${message.messageId}');
    _navigateFromMessage(message);
  }

  Future<void> handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) {
      return;
    }

    await _plugin.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'attendance_channel',
          'Attendance Updates',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data.toString(),
    );
  }

  void _onLocalNotificationTapped(NotificationResponse response) {
    AppLogger().info('Local notification tapped: ${response.payload}');
  }

  void _navigateFromMessage(RemoteMessage message) {
    serviceLocator.get<PushNotificationNavigator>().navigateFromMessage(message);
  }
}
