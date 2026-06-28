part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardState extends Equatable {
  const AdminDashboardState();

  @override
  List<Object?> get props => [];
}

class AdminDashboardInitial extends AdminDashboardState {
  const AdminDashboardInitial();
}

class AdminDashboardLoading extends AdminDashboardState {
  const AdminDashboardLoading();
}

class AdminDashboardLoaded extends AdminDashboardState {
  const AdminDashboardLoaded({required this.stats});

  final AdminDashboardStats stats;

  @override
  List<Object?> get props => [stats];
}

class AdminDashboardFailure extends AdminDashboardState {
  const AdminDashboardFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
