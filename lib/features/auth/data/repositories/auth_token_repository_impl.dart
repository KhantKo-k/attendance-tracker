import 'package:app_starter_kit_bloc/core/error/error_handler_guard.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/storage/secure_auth_token_storage.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_token_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthTokenRepository)
class AuthTokenRepositoryImpl implements AuthTokenRepository {
  final SecureAuthTokenStorage _authTokenStorage;

  AuthTokenRepositoryImpl({required SecureAuthTokenStorage authTokenStorage})
    : _authTokenStorage = authTokenStorage;

  @override
  Future<Either<AuthTokenPair?, Failure>> getAuthTokenPair() async {
    return ErrorHandlerGuard.on<AuthTokenPair?>(() async {
      return _authTokenStorage.read();
    });
  }

  @override
  Future<Either<void, Failure>> saveAuthTokenPair(
    AuthTokenPair authTokenPair,
  ) async {
    return ErrorHandlerGuard.on<void>(() async {
      await _authTokenStorage.write(authTokenPair);
    });
  }

  @override
  Future<Either<void, Failure>> deleteAuthTokenPair() async {
    return ErrorHandlerGuard.on<void>(() async {
      await _authTokenStorage.delete();
    });
  }
}
