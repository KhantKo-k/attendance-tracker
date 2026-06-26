import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:dartz/dartz.dart';

abstract class AuthTokenRepository {
  Future<Either<AuthTokenPair?, Failure>> getAuthTokenPair();
  Future<Either<void, Failure>> saveAuthTokenPair(AuthTokenPair authTokenPair);
  Future<Either<void, Failure>> deleteAuthTokenPair();
}