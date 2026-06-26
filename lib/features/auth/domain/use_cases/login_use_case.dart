import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_token_repository.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/user_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;
  final AuthTokenRepository _authTokenRepository;
  final UserSessionRepository _userSessionRepository;

  LoginUseCase({
    required AuthRepository authRepository,
    required AuthTokenRepository authTokenRepository,
    required UserSessionRepository userSessionRepository,
  }) : _authRepository = authRepository,
       _authTokenRepository = authTokenRepository,
       _userSessionRepository = userSessionRepository;

  Future<Either<User, Failure>> call(String userName, String password) async {
    final result = await _authRepository.login(userName, password);

    return await result.fold(
      (user) async {
        final tokenSave = await _authTokenRepository.saveAuthTokenPair(
          AuthTokenPair.fromUser(user),
        );
        return await tokenSave.fold(
          (_) async {
            final userSave = await _userSessionRepository.saveUser(user);
            return userSave.fold(
              (_) => Left<User, Failure>(user),
              Right<User, Failure>.new,
            );
          },
          Right<User, Failure>.new,
        );
      },
      (failure) async => Right(failure),
    );
  }
}
