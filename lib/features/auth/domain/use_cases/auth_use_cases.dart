import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/auth/domain/entities/user.dart';
import 'package:attendance_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  LoginUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<User, Failure>> call(String email, String password) {
    return _authRepository.login(email: email, password: password);
  }
}

@injectable
class RegisterUseCase {
  RegisterUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<User, Failure>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _authRepository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}

@injectable
class LogoutUseCase {
  LogoutUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Future<Either<void, Failure>> call() => _authRepository.logout();
}

@injectable
class WatchAuthUserUseCase {
  WatchAuthUserUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  Stream<User?> call() => _authRepository.watchAuthUser();
}
