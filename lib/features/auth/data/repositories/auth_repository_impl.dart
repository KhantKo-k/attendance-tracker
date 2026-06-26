import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/data/data_sources/auth_api.dart';
import 'package:app_starter_kit_bloc/features/auth/data/dtos/login_request.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiInterface _authApi;

  AuthRepositoryImpl({required AuthApiInterface authApi}) : _authApi = authApi;

  @override
  Future<Either<User, Failure>> login(String userName, String password) async {
    final response = await _authApi.login(
      LoginRequest(username: userName, password: password),
    );
    return response.fold(
      (loginResponse) => Left(User.fromLoginResponse(loginResponse)),
      (failure) => Right(failure),
    );
  }

  @override
  Future<Either<void, Failure>> logout() {
    // Clear the user data from the storage
    return Future.value(Left(null));
  }
}
