import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/entities/attendance_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc({required GetDashboardStatsUseCase getDashboardStatsUseCase})
    : _getDashboardStatsUseCase = getDashboardStatsUseCase,
      super(const AdminDashboardInitial()) {
    on<AdminDashboardStarted>(_onStarted);
    on<AdminDashboardRefreshed>(_onRefreshed);
  }

  final GetDashboardStatsUseCase _getDashboardStatsUseCase;

  Future<void> _onStarted(
    AdminDashboardStarted event,
    Emitter<AdminDashboardState> emit,
  ) async {
    await _loadStats(emit);
  }

  Future<void> _onRefreshed(
    AdminDashboardRefreshed event,
    Emitter<AdminDashboardState> emit,
  ) async {
    await _loadStats(emit);
  }

  Future<void> _loadStats(Emitter<AdminDashboardState> emit) async {
    emit(const AdminDashboardLoading());
    final result = await _getDashboardStatsUseCase();
    result.fold(
      (stats) => emit(AdminDashboardLoaded(stats: stats)),
      (failure) => emit(AdminDashboardFailure(failure: failure)),
    );
  }
}
