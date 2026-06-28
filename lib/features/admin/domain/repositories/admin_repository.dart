import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<AdminDashboardStats, Failure>> getDashboardStats();

  Future<Either<List<User>, Failure>> getUsers({
    String? searchQuery,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  });

  Future<Either<List<AttendanceLog>, Failure>> getUserAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  });
}
