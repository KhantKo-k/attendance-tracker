import 'package:app_starter_kit_bloc/features/auth/domain/entities/user_role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) required UserRole role,
    String? profileImageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

UserRole _roleFromJson(String value) => UserRole.fromFirestore(value);
String _roleToJson(UserRole role) => role.firestoreValue;
