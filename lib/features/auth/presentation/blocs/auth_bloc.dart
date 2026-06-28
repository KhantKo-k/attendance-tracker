import 'dart:async';

import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/core/firebase/admin_push_notification_service.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required WatchAuthUserUseCase watchAuthUserUseCase,
    required AdminPushNotificationService adminPushNotificationService,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _adminPushNotificationService = adminPushNotificationService,
       super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);

    _authSubscription = watchAuthUserUseCase().listen((user) {
      add(AuthUserChanged(user));
    });
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final AdminPushNotificationService _adminPushNotificationService;
  StreamSubscription<User?>? _authSubscription;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _loginUseCase(event.email, event.password);
    await result.fold<Future<void>>(
      (user) async {
        emit(Authenticated(user: user));
        unawaited(_adminPushNotificationService.syncForUser(user));
      },
      (failure) async {
        emit(AuthFailure(failure: failure));
      },
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _registerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    await result.fold<Future<void>>(
      (user) async {
        emit(Authenticated(user: user));
        unawaited(_adminPushNotificationService.syncForUser(user));
      },
      (failure) async {
        emit(AuthFailure(failure: failure));
      },
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    unawaited(_adminPushNotificationService.unsubscribeFromAdminTopic());
    await _logoutUseCase();
    emit(const Unauthenticated());
  }

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (state is AuthLoading) {
      return;
    }

    final user = event.user;
    if (user == null) {
      if (state is Authenticated) {
        unawaited(_adminPushNotificationService.unsubscribeFromAdminTopic());
      }
      emit(const Unauthenticated());
      return;
    }

    emit(Authenticated(user: user));
    unawaited(_adminPushNotificationService.syncForUser(user));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
