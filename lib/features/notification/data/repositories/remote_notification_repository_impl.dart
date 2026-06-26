import 'package:app_starter_kit_bloc/core/error/error_handler_guard.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/notification/data/dtos/notification_dtos.dart';
import 'package:app_starter_kit_bloc/features/notification/data/data_sources/notification_api.dart';
import 'package:app_starter_kit_bloc/features/notification/data/mappers/notification_dto_mapper.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/repositories/remote_notification_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteNotificationRepository)
class RemoteNotificationRepositoryImpl implements RemoteNotificationRepository {
  final NotificationApi notificationApi;

  RemoteNotificationRepositoryImpl({required this.notificationApi});

  @override
  Future<Either<NotificationList, Failure>> getNotifications({
    required NotificationType type,
    required int page,
    required int limit,
  }) async {
    final result = await notificationApi.getNotifications(
      type: type.name,
      page: page,
      limit: limit,
    );
    return result.guardedParse<NotificationList, NotificationListDto>(
      (left) => left.toDomain(),
    );
  }
}
