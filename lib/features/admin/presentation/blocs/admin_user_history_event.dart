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
  const AdminUserHistoryFilterChanged({
    this.startDate,
    this.endDate,
    this.clearStartDate = false,
    this.clearEndDate = false,
    this.clearAll = false,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final bool clearStartDate;
  final bool clearEndDate;
  final bool clearAll;

  @override
  List<Object?> get props => [
    startDate,
    endDate,
    clearStartDate,
    clearEndDate,
    clearAll,
  ];
}

class AdminUserHistoryRefreshed extends AdminUserHistoryEvent {
  const AdminUserHistoryRefreshed();
}
