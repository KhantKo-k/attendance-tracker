import 'package:app_starter_kit_bloc/features/auth/domain/entities/user.dart';

class AuthTokenPair {
  final String accessToken;
  final String refreshToken;

  const AuthTokenPair({required this.accessToken, required this.refreshToken});

  factory AuthTokenPair.fromJson(Map<String, dynamic> json) => AuthTokenPair(
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
  );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  factory AuthTokenPair.fromUser(User user) => AuthTokenPair(
    accessToken: user.accessToken,
    refreshToken: user.refreshToken,
  );
}
