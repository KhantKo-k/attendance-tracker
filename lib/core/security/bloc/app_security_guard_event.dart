part of 'app_security_guard_bloc.dart';


sealed class AppSecurityGuardEvent extends Equatable {
  const AppSecurityGuardEvent();

  @override
  List<Object> get props => [];
}

class StartSecurityGuard extends AppSecurityGuardEvent{}

class AppSecurityIssueDetected extends AppSecurityGuardEvent {
  final AppSecurityIssue issue;
  
  const AppSecurityIssueDetected({required this.issue});

  @override 
  List<Object> get props => [issue];
}