import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyAttendanceHistoryUseCase {
  GetMyAttendanceHistoryUseCase({required AttendanceRepository attendanceRepository})
    : _attendanceRepository = attendanceRepository;

  final AttendanceRepository _attendanceRepository;

  Future<Either<List<AttendanceLog>, Failure>> call(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _attendanceRepository.getUserHistory(
      userId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

@injectable
class GetAttendanceStatusUseCase {
  GetAttendanceStatusUseCase({required AttendanceRepository attendanceRepository})
    : _attendanceRepository = attendanceRepository;

  final AttendanceRepository _attendanceRepository;

  Future<Either<AttendanceStatus, Failure>> call(String userId) {
    return _attendanceRepository.getAttendanceStatus(userId);
  }
}

@injectable
class CheckInUseCase {
  CheckInUseCase({required AttendanceRepository attendanceRepository})
    : _attendanceRepository = attendanceRepository;

  final AttendanceRepository _attendanceRepository;

  Future<Either<AttendanceLog, Failure>> call({
    required String userId,
    required String userName,
  }) {
    return _attendanceRepository.checkIn(userId: userId, userName: userName);
  }
}

@injectable
class CheckOutUseCase {
  CheckOutUseCase({required AttendanceRepository attendanceRepository})
    : _attendanceRepository = attendanceRepository;

  final AttendanceRepository _attendanceRepository;

  Future<Either<AttendanceLog, Failure>> call({
    required String userId,
    required String userName,
  }) {
    return _attendanceRepository.checkOut(userId: userId, userName: userName);
  }
}

@injectable
class SyncPendingAttendanceUseCase {
  SyncPendingAttendanceUseCase({
    required AttendanceRepository attendanceRepository,
  }) : _attendanceRepository = attendanceRepository;

  final AttendanceRepository _attendanceRepository;

  Future<Either<void, Failure>> call() {
    return _attendanceRepository.syncPendingLogs();
  }
}
