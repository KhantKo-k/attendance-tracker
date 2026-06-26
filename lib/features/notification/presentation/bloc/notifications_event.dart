part of 'notifications_bloc.dart';

@freezed
abstract class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.fetchNotifications() = _FetchNotifications;

  const factory NotificationsEvent.loadMore() = _LoadMore;

  const factory NotificationsEvent.refresh() = _Refresh;

  const factory NotificationsEvent.typeChanged(NotificationType type) =
      _TypeChanged;
}
