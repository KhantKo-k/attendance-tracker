import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/repositories/remote_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  final RemoteNotificationRepository _remoteNotificationRepository;

  GetNotificationsUseCase({required RemoteNotificationRepository remoteNotificationRepository}) : _remoteNotificationRepository = remoteNotificationRepository;

  Future<Either<NotificationList, Failure>> call({
    required NotificationType type,
    required int page,
    required int limit,
  }) async {
    return await _remoteNotificationRepository.getNotifications(type: type, page: page, limit: limit);
  }
}