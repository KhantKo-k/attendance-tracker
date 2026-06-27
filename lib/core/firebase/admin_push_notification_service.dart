import 'package:attendance_tracker/core/firebase/fcm_service.dart';
import 'package:attendance_tracker/core/firebase/push_notification_constants.dart';
import 'package:attendance_tracker/core/logging/app_logger.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user_role.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AdminPushNotificationService {
  Future<void> syncForUser(User? user) async {
    try {
      if (user?.role == UserRole.admin) {
        await FcmService().subscribeToTopic(PushNotificationConstants.adminTopic);
        AppLogger().info('Subscribed to admin push notifications');
        return;
      }

      await unsubscribeFromAdminTopic();
    } catch (e, s) {
      AppLogger().warning('Push notification sync failed: $e');
      AppLogger().debug(s.toString());
    }
  }

  Future<void> unsubscribeFromAdminTopic() async {
    try {
      await FcmService().unsubscribeFromTopic(PushNotificationConstants.adminTopic);
      AppLogger().info('Unsubscribed from admin push notifications');
    } catch (e, s) {
      AppLogger().warning('Push notification unsubscribe failed: $e');
      AppLogger().debug(s.toString());
    }
  }
}
