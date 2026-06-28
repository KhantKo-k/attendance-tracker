part of 'admin_users_bloc.dart';

abstract class AdminUsersState extends Equatable {
  const AdminUsersState();

  @override
  List<Object?> get props => [];
}

class AdminUsersInitial extends AdminUsersState {
  const AdminUsersInitial();
}

class AdminUsersLoading extends AdminUsersState {
  const AdminUsersLoading();
}

class AdminUsersLoaded extends AdminUsersState {
  const AdminUsersLoaded({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

class AdminUsersFailure extends AdminUsersState {
  const AdminUsersFailure({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
