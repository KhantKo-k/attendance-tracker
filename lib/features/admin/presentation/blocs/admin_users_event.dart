part of 'admin_users_bloc.dart';

abstract class AdminUsersEvent extends Equatable {
  const AdminUsersEvent();

  @override
  List<Object?> get props => [];
}

class AdminUsersStarted extends AdminUsersEvent {
  const AdminUsersStarted();
}

class AdminUsersSearchChanged extends AdminUsersEvent {
  const AdminUsersSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class AdminUsersRefreshed extends AdminUsersEvent {
  const AdminUsersRefreshed();
}
