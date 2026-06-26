import 'package:app_starter_kit_bloc/features/notification/data/dtos/notification_dtos.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';

extension NotificationTypeMapper on String {
  NotificationType toNotificationType() => NotificationType.values.firstWhere((e) => e.name == this);
}

extension NotificationDtoMapper on NotificationDto {
  Notification toDomain() => Notification(
    id: id  ,
    type: type.toNotificationType(),
    title: title,
    body: body,
    image: image,
    url: url,
  );
}

extension NotificationListDtoMapper on NotificationListDto {
  NotificationList toDomain() => NotificationList(
    notifications: notifications.map((e) => e.toDomain()).toList(),
    total: total,
    page: page,
    limit: limit,
  );
}