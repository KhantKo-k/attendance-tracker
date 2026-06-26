import 'package:app_starter_kit_bloc/features/auth/data/dtos/login_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    required String image,
    required String accessToken,
    required String refreshToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromLoginResponse(LoginResponse loginResponse) => User(
    id: loginResponse.id,
    username: loginResponse.username,
    email: loginResponse.email,
    firstName: loginResponse.firstName,
    lastName: loginResponse.lastName,
    gender: loginResponse.gender,
    image: loginResponse.image,
    accessToken: loginResponse.accessToken,
    refreshToken: loginResponse.refreshToken,
  );
}
