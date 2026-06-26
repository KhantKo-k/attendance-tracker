part of 'app_security_guard_bloc.dart';


sealed class AppSecurityGuardState extends Equatable {
  const AppSecurityGuardState();

  @override
  List<Object> get props => [];
}

class AppSecurityGuardInitial extends AppSecurityGuardState {}

class AppSecurityGuardLoading extends AppSecurityGuardState {}

class AppSecurityGuardLoaded extends AppSecurityGuardState {}

class AppSecurityGuardError extends AppSecurityGuardState {
  final AppSecurityIssue issue;

  const AppSecurityGuardError({required this.issue});

  @override 
  List<Object> get props => [issue];
}