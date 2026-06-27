part of 'admin_user_history_bloc.dart';

abstract class AdminUserHistoryState extends Equatable {
  const AdminUserHistoryState();

  @override
  List<Object?> get props => [];
}

class AdminUserHistoryInitial extends AdminUserHistoryState {
  const AdminUserHistoryInitial();
}

class AdminUserHistoryLoading extends AdminUserHistoryState {
  const AdminUserHistoryLoading();
}

class AdminUserHistoryLoaded extends AdminUserHistoryState {
  const AdminUserHistoryLoaded({required this.logs});

  final List<AttendanceLog> logs;

  @override
  List<Object?> get props => [logs];
}

class AdminUserHistoryFailure extends AdminUserHistoryState {
  const AdminUserHistoryFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
