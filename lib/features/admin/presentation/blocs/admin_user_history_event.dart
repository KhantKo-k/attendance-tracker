part of 'admin_user_history_bloc.dart';

abstract class AdminUserHistoryEvent extends Equatable {
  const AdminUserHistoryEvent();

  @override
  List<Object?> get props => [];
}

class AdminUserHistoryStarted extends AdminUserHistoryEvent {
  const AdminUserHistoryStarted();
}

class AdminUserHistoryFilterChanged extends AdminUserHistoryEvent {
  const AdminUserHistoryFilterChanged({this.startDate, this.endDate});

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class AdminUserHistoryRefreshed extends AdminUserHistoryEvent {
  const AdminUserHistoryRefreshed();
}
