part of 'admin_user_history_bloc.dart';

abstract class AdminUserHistoryState extends Equatable {
  const AdminUserHistoryState({this.startDate, this.endDate});

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class AdminUserHistoryInitial extends AdminUserHistoryState {
  const AdminUserHistoryInitial();
}

class AdminUserHistoryLoading extends AdminUserHistoryState {
  const AdminUserHistoryLoading({super.startDate, super.endDate});
}

class AdminUserHistoryLoaded extends AdminUserHistoryState {
  const AdminUserHistoryLoaded({
    required this.logs,
    super.startDate,
    super.endDate,
  });

  final List<AttendanceLog> logs;

  @override
  List<Object?> get props => [logs, startDate, endDate];
}

class AdminUserHistoryFailure extends AdminUserHistoryState {
  const AdminUserHistoryFailure({
    required this.failure,
    super.startDate,
    super.endDate,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure, startDate, endDate];
}
