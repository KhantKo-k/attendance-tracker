import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract interface class RemoteNotificationRepository {
  Future<Either<NotificationList, Failure>> getNotifications({
    required NotificationType type,
    required int page,
    required int limit,
  });
}