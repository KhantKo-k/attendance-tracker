part of 'attendance_history_bloc.dart';

abstract class AttendanceHistoryEvent extends Equatable {
  const AttendanceHistoryEvent();

  @override
  List<Object?> get props => [];
}

class AttendanceHistoryStarted extends AttendanceHistoryEvent {
  const AttendanceHistoryStarted();
}

class AttendanceHistoryRefreshed extends AttendanceHistoryEvent {
  const AttendanceHistoryRefreshed();
}
