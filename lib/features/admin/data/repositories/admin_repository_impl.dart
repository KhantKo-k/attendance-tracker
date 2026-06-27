import 'package:attendance_tracker/core/error/error_handler_guard.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/admin/domain/repositories/admin_repository.dart';
import 'package:attendance_tracker/features/attendance/data/datasources/attendance_firestore_datasource.dart';
import 'package:attendance_tracker/features/attendance/domain/entities/attendance_entities.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AdminRepository)
class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl({
    required FirebaseFirestore firestore,
    required AttendanceFirestoreDatasource attendanceDatasource,
  }) : _firestore = firestore,
       _attendanceDatasource = attendanceDatasource;

  final FirebaseFirestore _firestore;
  final AttendanceFirestoreDatasource _attendanceDatasource;
  static const _usersCollection = 'users';

  @override
  Future<Either<AdminDashboardStats, Failure>> getDashboardStats() async {
    return ErrorHandlerGuard.on<AdminDashboardStats>(() async {
      final totalUsers = await _attendanceDatasource.countUsers();
      final todayCheckIns = await _attendanceDatasource.countTodayLogs(
        AttendanceType.checkIn,
      );
      final todayCheckOuts = await _attendanceDatasource.countTodayLogs(
        AttendanceType.checkOut,
      );
      return AdminDashboardStats(
        totalUsers: totalUsers,
        todayCheckIns: todayCheckIns,
        todayCheckOuts: todayCheckOuts,
      );
    });
  }

  @override
  Future<Either<List<User>, Failure>> getUsers({
    String? searchQuery,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) async {
    return ErrorHandlerGuard.on<List<User>>(() async {
      Query<Map<String, dynamic>> query = _firestore
          .collection(_usersCollection)
          .orderBy('name')
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      var users = snapshot.docs.map(_mapUser).toList();

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final queryLower = searchQuery.trim().toLowerCase();
        users = users
            .where(
              (user) =>
                  user.name.toLowerCase().contains(queryLower) ||
                  user.email.toLowerCase().contains(queryLower),
            )
            .toList();
      }

      return users;
    });
  }

  @override
  Future<Either<List<AttendanceLog>, Failure>> getUserAttendanceHistory({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return ErrorHandlerGuard.on<List<AttendanceLog>>(() async {
      return _attendanceDatasource.getAllLogs(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
      );
    });
  }

  User _mapUser(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return User(
      id: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: UserRole.fromFirestore(data['role'] as String?),
      profileImageUrl: data['profileImageUrl'] as String?,
    );
  }
}
