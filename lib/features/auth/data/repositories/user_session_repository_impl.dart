import 'dart:convert';

import 'package:app_starter_kit_bloc/core/error/error_handler_guard.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/storage/secure_user_storage.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/user_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserSessionRepository)
class UserSessionRepositoryImpl implements UserSessionRepository {
  UserSessionRepositoryImpl({required SecureUserStorage secureUserStorage})
    : _secureUserStorage = secureUserStorage;

  final SecureUserStorage _secureUserStorage;

  @override
  Future<Either<void, Failure>> saveUser(User user) async {
    return ErrorHandlerGuard.on<void>(() async {
      final json = jsonEncode(user.toJson());
      await _secureUserStorage.write(json);
    });
  }

  @override
  Future<Either<User?, Failure>> readUser() async {
    return ErrorHandlerGuard.on<User?>(() async {
      final raw = await _secureUserStorage.read();
      if (raw == null || raw.isEmpty) {
        return null;
      }
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return User.fromJson(map);
    });
  }

  @override
  Future<Either<void, Failure>> deleteUser() async {
    return ErrorHandlerGuard.on<void>(() async {
      await _secureUserStorage.delete();
    });
  }
}
