import 'dart:io';

import 'package:app_starter_kit_bloc/core/storage/secure_auth_token_storage.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_urls.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:injectable/injectable.dart';
import 'package:fresh_dio/fresh_dio.dart';

@module
abstract class RefreshTokenInterceptorModule {
  @injectable
  Fresh<AuthTokenPair> refreshTokenInterceptor(
    SecureAuthTokenStorage secureAuthTokenStorage,
  ) => Fresh<AuthTokenPair>(
    tokenStorage: secureAuthTokenStorage,
    tokenHeader: (token) {
      // This function is called for every request to add the token to headers
      return {HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'};
    },
    refreshToken: (token, client) async {
      // This function is called when a 401 error is received
      try {
        final response = await client.post(
          AuthUrls.refreshToken,
          data: {
            'refreshToken': token!.refreshToken,
            'accessToken': token.accessToken,
          },
        );

        final newTokens = response.data;
        return AuthTokenPair(
          accessToken: newTokens['accessToken'],
          refreshToken: newTokens['refreshToken'],
        );
      } catch (e) {
        // If refresh fails, throw to trigger logout
        throw RevokeTokenException();
      }
    },
    shouldRefresh: (response) {
      // Determine if we should attempt a token refresh
      return response?.statusCode == 401;
    },
  );
}
