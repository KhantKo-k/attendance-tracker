part of 'attendance_history_bloc.dart';

abstract class AttendanceHistoryState extends Equatable {
  const AttendanceHistoryState();

  @override
  List<Object?> get props => [];
}

class AttendanceHistoryInitial extends AttendanceHistoryState {
  const AttendanceHistoryInitial();
}

class AttendanceHistoryLoading extends AttendanceHistoryState {
  const AttendanceHistoryLoading();
}

class AttendanceHistoryLoaded extends AttendanceHistoryState {
  const AttendanceHistoryLoaded({required this.logs});

  final List<AttendanceLog> logs;

  @override
  List<Object?> get props => [logs];
}

class AttendanceHistoryFailure extends AttendanceHistoryState {
  const AttendanceHistoryFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
