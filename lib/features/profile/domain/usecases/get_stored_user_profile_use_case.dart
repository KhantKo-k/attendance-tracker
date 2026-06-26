import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/repositories/user_session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetStoredUserProfileUseCase {
  GetStoredUserProfileUseCase(this._userSessionRepository);

  final UserSessionRepository _userSessionRepository;

  Future<Either<User?, Failure>> call() =>
      _userSessionRepository.readUser();
}
