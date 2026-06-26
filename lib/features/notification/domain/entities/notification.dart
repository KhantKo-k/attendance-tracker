import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

enum NotificationType {
  activity,
  offer,
  announcement;

  @override
  String toString() => name;
}

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String id,
    required NotificationType type,
    required String title,
    required String body,
    required String image,
    required String url,
  }) = _Notification;
}

@freezed 
abstract class NotificationList with _$NotificationList {
  const factory NotificationList({
    required List<Notification> notifications,
    required int total,
    required int page,
    required int limit,
  }) = _NotificationList;
}