import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
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
