import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_token_repository.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/user_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final AuthRepository _authRepository;
  final AuthTokenRepository _authTokenRepository;
  final UserSessionRepository _userSessionRepository;

  LogoutUseCase({
    required AuthRepository authRepository,
    required AuthTokenRepository authTokenRepository,
    required UserSessionRepository userSessionRepository,
  }) : _authRepository = authRepository,
       _authTokenRepository = authTokenRepository,
       _userSessionRepository = userSessionRepository;

  Future<Either<void, Failure>> call() async {
    final result = await _authRepository.logout();

    return await result.fold(
      (_) async {
        final tokenDelete = await _authTokenRepository.deleteAuthTokenPair();
        return await tokenDelete.fold(
          (_) async => _userSessionRepository.deleteUser(),
          Right<void, Failure>.new,
        );
      },
      (failure) async => Right(failure),
    );
  }
}
