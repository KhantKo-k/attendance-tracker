import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/admin/domain/repositories/admin_repository.dart';
import 'package:app_starter_kit_bloc/features/attendance/domain/entities/attendance_entities.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDashboardStatsUseCase {
  GetDashboardStatsUseCase({required AdminRepository adminRepository})
    : _adminRepository = adminRepository;

  final AdminRepository _adminRepository;

  Future<Either<AdminDashboardStats, Failure>> call() {
    return _adminRepository.getDashboardStats();
  }
}

@injectable
class GetUsersUseCase {
  GetUsersUseCase({required AdminRepository adminRepository})
    : _adminRepository = adminRepository;

  final AdminRepository _adminRepository;

  Future<Either<List<User>, Failure>> call({
    String? searchQuery,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
  }) {
    return _adminRepository.getUsers(
      searchQuery: searchQuery,
      limit: limit,
      startAfter: startAfter,
    );
  }
}

@injectable
class GetUserAttendanceHistoryUseCase {
  GetUserAttendanceHistoryUseCase({required AdminRepository adminRepository})
    : _adminRepository = adminRepository;

  final AdminRepository _adminRepository;

  Future<Either<List<AttendanceLog>, Failure>> call({
    required String userId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _adminRepository.getUserAttendanceHistory(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
