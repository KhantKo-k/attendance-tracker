import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_users_event.dart';
part 'admin_users_state.dart';

class AdminUsersBloc extends Bloc<AdminUsersEvent, AdminUsersState> {
  AdminUsersBloc({required GetUsersUseCase getUsersUseCase})
    : _getUsersUseCase = getUsersUseCase,
      super(const AdminUsersInitial()) {
    on<AdminUsersStarted>(_onStarted);
    on<AdminUsersSearchChanged>(_onSearchChanged);
    on<AdminUsersRefreshed>(_onRefreshed);
  }

  final GetUsersUseCase _getUsersUseCase;
  String _searchQuery = '';

  Future<void> _onStarted(
    AdminUsersStarted event,
    Emitter<AdminUsersState> emit,
  ) async {
    await _loadUsers(emit);
  }

  Future<void> _onSearchChanged(
    AdminUsersSearchChanged event,
    Emitter<AdminUsersState> emit,
  ) async {
    _searchQuery = event.query;
    await _loadUsers(emit);
  }

  Future<void> _onRefreshed(
    AdminUsersRefreshed event,
    Emitter<AdminUsersState> emit,
  ) async {
    await _loadUsers(emit);
  }

  Future<void> _loadUsers(Emitter<AdminUsersState> emit) async {
    emit(const AdminUsersLoading());
    final result = await _getUsersUseCase(searchQuery: _searchQuery);
    result.fold(
      (users) => emit(AdminUsersLoaded(users: users)),
      (failure) => emit(AdminUsersFailure(failure: failure)),
    );
  }
}
