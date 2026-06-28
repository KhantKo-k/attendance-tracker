import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:dartz/dartz.dart';

abstract class AttendanceRepository {
  Future<Either<AttendanceStatus, Failure>> getAttendanceStatus(String userId);

  Future<Either<AttendanceLog, Failure>> checkIn({
    required String userId,
    required String userName,
  });

  Future<Either<AttendanceLog, Failure>> checkOut({
    required String userId,
    required String userName,
  });

  Future<Either<List<AttendanceLog>, Failure>> getUserHistory(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<void, Failure>> syncPendingLogs();
}
