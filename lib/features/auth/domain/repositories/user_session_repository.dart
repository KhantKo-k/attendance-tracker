import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

/// Persists and restores the signed-in [User] using secure storage.
abstract class UserSessionRepository {
  Future<Either<void, Failure>> saveUser(User user);

  Future<Either<User?, Failure>> readUser();

  Future<Either<void, Failure>> deleteUser();
}
