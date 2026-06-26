

import 'package:app_starter_kit_bloc/core/security/talsec_service.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_security_guard_event.dart';
part 'app_security_guard_state.dart';

@injectable
class AppSecurityGuardBloc extends Bloc<AppSecurityGuardEvent, AppSecurityGuardState> {
  AppSecurityGuardBloc() : super(AppSecurityGuardInitial()) {
    on<StartSecurityGuard>(_onStartSecurityGuard);
    on<AppSecurityIssueDetected>(_onAppSecurityIssue);
  }

  void _onStartSecurityGuard( 
    StartSecurityGuard event,
    Emitter<AppSecurityGuardState> emit,
  ) {
    emit(AppSecurityGuardLoading());

    AppLogger().info("Initializing security guard");

    TalsecService.initTalsecThreatDetection();

    AppLogger().info('Starting security guard');
    TalsecService.startTalsecThreatDetection();
    
    emit(AppSecurityGuardLoaded());

  }

  void _onAppSecurityIssue(
    AppSecurityIssueDetected event,
    Emitter<AppSecurityGuardState> emit,
  ) {
    AppLogger().error('App security issue detected: ${event.issue}');

    if(state is AppSecurityGuardError) {
      return;
    }

    emit(AppSecurityGuardError(issue: event.issue));
  }

}