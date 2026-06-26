import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/entities/notification.dart';
import 'package:app_starter_kit_bloc/features/notification/domain/use_cases/get_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';
part 'notifications_bloc.freezed.dart';

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationsBloc(this._getNotificationsUseCase)
    : super(const NotificationsState()) {
    on<_FetchNotifications>(_onFetchNotifications);
    on<_LoadMore>(_onLoadMore);
    on<_Refresh>(_onRefresh);
    on<_TypeChanged>(_onTypeChanged);
  }

  Future<void> _onFetchNotifications(
    _FetchNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        page: 1,
        hasMore: true,
        failure: null,
        notifications: [],
      ),
    );

    final result = await _getNotificationsUseCase(
      type: state.type,
      page: 1,
      limit: state.limit,
    );

    result.fold(
      (data) => emit(
        state.copyWith(
          notifications: data.notifications,
          page: data.page,
          total: data.total,
          hasMore: data.notifications.length < data.total,
          isLoading: false,
          failure: null,
        ),
      ),
      (failure) => emit(state.copyWith(failure: failure, isLoading: false)),
    );
  }

  Future<void> _onLoadMore(
    _LoadMore event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;
    final result = await _getNotificationsUseCase(
      type: state.type,
      page: nextPage,
      limit: state.limit,
    );

    result.fold(
      (data) {
        final updated = [...state.notifications, ...data.notifications];
        emit(
          state.copyWith(
            notifications: updated,
            page: data.page,
            total: data.total,
            hasMore: updated.length < data.total,
            isLoadingMore: false,
            failure: null,
          ),
        );
      },
      (failure) =>
          emit(state.copyWith(failure: failure, isLoadingMore: false)),
    );
  }

  Future<void> _onRefresh(
    _Refresh event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.isLoading) return;
    add(const NotificationsEvent.fetchNotifications());
  }

  Future<void> _onTypeChanged(
    _TypeChanged event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.type == event.type) return;
    emit(state.copyWith(type: event.type));
    add(const NotificationsEvent.fetchNotifications());
  }
}
