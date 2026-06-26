import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';

part 'notification_dtos.freezed.dart';
part 'notification_dtos.g.dart';

@freezed
abstract class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String type,
    required String title,
    required String body,
    required String image,
    required String url,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

@freezed
abstract class NotificationListDto with _$NotificationListDto {
  const factory NotificationListDto({
    required List<NotificationDto> notifications,
    required int total,
    required int page,
    required int limit,
  }) = _NotificationListDto;

  factory NotificationListDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationListDtoFromJson(json);
}

NotificationDto deserializeNotificationDto(Map<String, dynamic> json) =>
    NotificationDto.fromJson(json);

NotificationListDto deserializeNotificationListDto(Map<String, dynamic> json) =>
    NotificationListDto.fromJson(json);

String serializeNotificationType(NotificationType type) => type.name;

extension NotificationDtoMapper on NotificationDto {
  Notification toEntity() => Notification(
        id: id,
        type: NotificationType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => NotificationType.announcement,
        ),
        title: title,
        body: body,
        image: image,
        url: url,
      );
}

extension NotificationListDtoMapper on NotificationListDto {
  NotificationList toEntity() => NotificationList(
        notifications: notifications.map((e) => e.toEntity()).toList(),
        total: total,
        page: page,
        limit: limit,
      );
}