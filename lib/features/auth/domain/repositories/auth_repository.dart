import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Stream<User?> watchAuthUser();

  Future<Either<User, Failure>> login({
    required String email,
    required String password,
  });

  Future<Either<User, Failure>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<void, Failure>> logout();
}
