enum AttendanceType {
  checkIn,
  checkOut;

  String get firestoreValue => name == 'checkIn' ? 'check_in' : 'check_out';

  static AttendanceType fromFirestore(String? value) {
    return value == 'check_out' ? AttendanceType.checkOut : AttendanceType.checkIn;
  }
}

class AttendanceLog {
  const AttendanceLog({
    required this.id,
    required this.userId,
    required this.userName,
    required this.type,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.address,
    this.isPending = false,
  });

  final String id;
  final String userId;
  final String userName;
  final AttendanceType type;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String? address;
  final bool isPending;
}

class AttendanceStatus {
  const AttendanceStatus({
    required this.isCheckedIn,
    required this.hasCheckedInToday,
    required this.hasCheckedOutToday,
    required this.openSessionFromPriorDay,
    this.lastLog,
  });

  final bool isCheckedIn;
  final bool hasCheckedInToday;
  final bool hasCheckedOutToday;
  final bool openSessionFromPriorDay;
  final AttendanceLog? lastLog;

  bool get canCheckIn => !isCheckedIn && !hasCheckedInToday;

  bool get canCheckOut {
    if (!isCheckedIn) {
      return false;
    }
    if (openSessionFromPriorDay) {
      return true;
    }
    return hasCheckedInToday && !hasCheckedOutToday;
  }

  bool get isDayComplete =>
      hasCheckedInToday && hasCheckedOutToday && !isCheckedIn;
}

class AdminDashboardStats {
  const AdminDashboardStats({
    required this.totalUsers,
    required this.todayCheckIns,
    required this.todayCheckOuts,
  });

  final int totalUsers;
  final int todayCheckIns;
  final int todayCheckOuts;
}
