import 'dart:async';

import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/use_cases/login_use_case.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginEvent);
    on<LogoutRequested>(_onLogoutEvent);
    on<AuthenticatedUserRestored>(_onAuthenticatedUserRestored);
  }

  Future<void> _onLoginEvent(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await loginUseCase(event.userName, event.password);
    result.fold((user) {
      emit(Authenticated(user: user));
    }, (failure) => emit(LoginFail(failure: failure)));
  }

  Future<void> _onLogoutEvent(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUseCase();
    emit(Unauthenticated());
  }

  void _onAuthenticatedUserRestored(
    AuthenticatedUserRestored event,
    Emitter<AuthState> emit,
  ) {
    emit(Authenticated(user: event.user));
  }
}
