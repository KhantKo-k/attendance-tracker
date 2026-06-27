part of 'attendance_home_bloc.dart';

abstract class AttendanceHomeState extends Equatable {
  const AttendanceHomeState();

  @override
  List<Object?> get props => [];
}

class AttendanceHomeInitial extends AttendanceHomeState {
  const AttendanceHomeInitial();
}

class AttendanceHomeLoading extends AttendanceHomeState {
  const AttendanceHomeLoading();
}

class AttendanceHomeLoaded extends AttendanceHomeState {
  const AttendanceHomeLoaded({required this.status});

  final AttendanceStatus status;

  @override
  List<Object?> get props => [status];
}

class AttendanceHomeFailure extends AttendanceHomeState {
  const AttendanceHomeFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
