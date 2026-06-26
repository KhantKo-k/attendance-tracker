import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';
import 'package:app_starter_kit_bloc/features/profile/domain/usecases/get_stored_user_profile_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class ProfileEmpty extends ProfileState {
  const ProfileEmpty();
}

class ProfileFailure extends ProfileState {
  const ProfileFailure(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getStoredUserProfileUseCase)
    : super(const ProfileInitial()) {
    loadProfile();
  }

  final GetStoredUserProfileUseCase _getStoredUserProfileUseCase;

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await _getStoredUserProfileUseCase();
    result.fold(
      (user) {
        if (user == null) {
          emit(const ProfileEmpty());
        } else {
          emit(ProfileLoaded(user));
        }
      },
      (failure) => emit(ProfileFailure(failure)),
    );
  }
}
