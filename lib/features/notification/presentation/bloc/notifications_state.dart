part of 'notifications_bloc.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default([]) List<Notification> notifications,
    @Default(NotificationType.activity) NotificationType type,
    @Default(1) int page,
    @Default(10) int limit,
    @Default(0) int total,
    @Default(true) bool hasMore,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    Failure? failure,
  }) = _NotificationsState;
}
