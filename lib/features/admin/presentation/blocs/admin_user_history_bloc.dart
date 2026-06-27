import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_user_history_event.dart';
part 'admin_user_history_state.dart';

class AdminUserHistoryBloc
    extends Bloc<AdminUserHistoryEvent, AdminUserHistoryState> {
  AdminUserHistoryBloc({
    required GetUserAttendanceHistoryUseCase getUserAttendanceHistoryUseCase,
    required User user,
  }) : _getUserAttendanceHistoryUseCase = getUserAttendanceHistoryUseCase,
       _user = user,
       super(const AdminUserHistoryInitial()) {
    on<AdminUserHistoryStarted>(_onStarted);
    on<AdminUserHistoryFilterChanged>(_onFilterChanged);
    on<AdminUserHistoryRefreshed>(_onRefreshed);
  }

  final GetUserAttendanceHistoryUseCase _getUserAttendanceHistoryUseCase;
  final User _user;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _onStarted(
    AdminUserHistoryStarted event,
    Emitter<AdminUserHistoryState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _onFilterChanged(
    AdminUserHistoryFilterChanged event,
    Emitter<AdminUserHistoryState> emit,
  ) async {
    if (event.clearAll) {
      _startDate = null;
      _endDate = null;
    } else {
      if (event.clearStartDate) {
        _startDate = null;
      } else if (event.startDate != null) {
        _startDate = event.startDate;
      }

      if (event.clearEndDate) {
        _endDate = null;
      } else if (event.endDate != null) {
        _endDate = event.endDate;
      }
    }

    if (_startDate != null &&
        _endDate != null &&
        _startDate!.isAfter(_endDate!)) {
      _endDate = _startDate;
    }

    await _loadHistory(emit);
  }

  Future<void> _onRefreshed(
    AdminUserHistoryRefreshed event,
    Emitter<AdminUserHistoryState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _loadHistory(Emitter<AdminUserHistoryState> emit) async {
    emit(
      AdminUserHistoryLoading(startDate: _startDate, endDate: _endDate),
    );
    final result = await _getUserAttendanceHistoryUseCase(
      userId: _user.id,
      startDate: _startDate,
      endDate: _endDate,
    );
    result.fold(
      (logs) => emit(
        AdminUserHistoryLoaded(
          logs: logs,
          startDate: _startDate,
          endDate: _endDate,
        ),
      ),
      (failure) => emit(
        AdminUserHistoryFailure(
          failure: failure,
          startDate: _startDate,
          endDate: _endDate,
        ),
      ),
    );
  }
}
