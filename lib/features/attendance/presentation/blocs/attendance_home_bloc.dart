import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/entities/attendance_entities.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/use_cases/attendance_use_cases.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_home_event.dart';
part 'attendance_home_state.dart';

class AttendanceHomeBloc extends Bloc<AttendanceHomeEvent, AttendanceHomeState> {
  AttendanceHomeBloc({
    required GetAttendanceStatusUseCase getAttendanceStatusUseCase,
    required CheckInUseCase checkInUseCase,
    required CheckOutUseCase checkOutUseCase,
    required SyncPendingAttendanceUseCase syncPendingAttendanceUseCase,
    required User user,
  }) : _getAttendanceStatusUseCase = getAttendanceStatusUseCase,
       _checkInUseCase = checkInUseCase,
       _checkOutUseCase = checkOutUseCase,
       _syncPendingAttendanceUseCase = syncPendingAttendanceUseCase,
       _user = user,
       super(const AttendanceHomeInitial()) {
    on<AttendanceHomeStarted>(_onStarted);
    on<AttendanceCheckInRequested>(_onCheckIn);
    on<AttendanceCheckOutRequested>(_onCheckOut);
  }

  final GetAttendanceStatusUseCase _getAttendanceStatusUseCase;
  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final SyncPendingAttendanceUseCase _syncPendingAttendanceUseCase;
  final User _user;

  Future<void> _onStarted(
    AttendanceHomeStarted event,
    Emitter<AttendanceHomeState> emit,
  ) async {
    emit(const AttendanceHomeLoading());
    await _syncPendingAttendanceUseCase();
    await _loadStatus(emit);
  }

  Future<void> _onCheckIn(
    AttendanceCheckInRequested event,
    Emitter<AttendanceHomeState> emit,
  ) async {
    emit(const AttendanceHomeLoading());
    final result = await _checkInUseCase(
      userId: _user.id,
      userName: _user.name,
    );
    await result.fold(
      (_) async => _loadStatus(emit),
      (failure) async => emit(AttendanceHomeFailure(failure: failure)),
    );
  }

  Future<void> _onCheckOut(
    AttendanceCheckOutRequested event,
    Emitter<AttendanceHomeState> emit,
  ) async {
    emit(const AttendanceHomeLoading());
    final result = await _checkOutUseCase(
      userId: _user.id,
      userName: _user.name,
    );
    await result.fold(
      (_) async => _loadStatus(emit),
      (failure) async => emit(AttendanceHomeFailure(failure: failure)),
    );
  }

  Future<void> _loadStatus(Emitter<AttendanceHomeState> emit) async {
    final result = await _getAttendanceStatusUseCase(_user.id);
    result.fold(
      (status) => emit(AttendanceHomeLoaded(status: status)),
      (failure) => emit(AttendanceHomeFailure(failure: failure)),
    );
  }
}
