import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/attendance/domain/use_cases/attendance_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'attendance_history_event.dart';
part 'attendance_history_state.dart';

class AttendanceHistoryBloc
    extends Bloc<AttendanceHistoryEvent, AttendanceHistoryState> {
  AttendanceHistoryBloc({
    required GetMyAttendanceHistoryUseCase getMyAttendanceHistoryUseCase,
    required SyncPendingAttendanceUseCase syncPendingAttendanceUseCase,
    required String userId,
  }) : _getMyAttendanceHistoryUseCase = getMyAttendanceHistoryUseCase,
       _syncPendingAttendanceUseCase = syncPendingAttendanceUseCase,
       _userId = userId,
       super(const AttendanceHistoryInitial()) {
    on<AttendanceHistoryStarted>(_onStarted);
    on<AttendanceHistoryRefreshed>(_onRefreshed);
  }

  final GetMyAttendanceHistoryUseCase _getMyAttendanceHistoryUseCase;
  final SyncPendingAttendanceUseCase _syncPendingAttendanceUseCase;
  final String _userId;

  Future<void> _onStarted(
    AttendanceHistoryStarted event,
    Emitter<AttendanceHistoryState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _onRefreshed(
    AttendanceHistoryRefreshed event,
    Emitter<AttendanceHistoryState> emit,
  ) async {
    await _syncPendingAttendanceUseCase();
    await _loadHistory(emit);
  }

  Future<void> _loadHistory(Emitter<AttendanceHistoryState> emit) async {
    emit(const AttendanceHistoryLoading());
    final result = await _getMyAttendanceHistoryUseCase(_userId);
    result.fold(
      (logs) => emit(AttendanceHistoryLoaded(logs: logs)),
      (failure) => emit(AttendanceHistoryFailure(failure: failure)),
    );
  }
}
