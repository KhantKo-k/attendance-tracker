part of 'attendance_home_bloc.dart';

abstract class AttendanceHomeEvent extends Equatable {
  const AttendanceHomeEvent();

  @override
  List<Object?> get props => [];
}

class AttendanceHomeStarted extends AttendanceHomeEvent {
  const AttendanceHomeStarted();
}

class AttendanceCheckInRequested extends AttendanceHomeEvent {
  const AttendanceCheckInRequested();
}

class AttendanceCheckOutRequested extends AttendanceHomeEvent {
  const AttendanceCheckOutRequested();
}
