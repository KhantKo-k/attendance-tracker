import 'package:attendance_tracker/core/firebase/push_notification_constants.dart';
import 'package:attendance_tracker/core/logging/app_logger.dart';
import 'package:attendance_tracker/core/navigation/app_router.dart';
import 'package:attendance_tracker/features/admin/admin_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PushNotificationNavigator {
  PushNotificationNavigator(this._appRouter);

  final AppRouter _appRouter;

  void navigateFromMessage(RemoteMessage message) {
    final type = message.data[PushNotificationConstants.dataType];
    if (type != PushNotificationConstants.typeCheckIn) {
      return;
    }

    AppLogger().info(
      'Navigating from check-in notification for user '
      '${message.data[PushNotificationConstants.dataUserId]}',
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _appRouter.navigateToAdminDashboard();
    });
  }
}
