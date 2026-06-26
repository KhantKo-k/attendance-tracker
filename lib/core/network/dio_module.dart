import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:app_starter_kit_bloc/features/auth/domain/entities/auth_token_pair.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

const publicApiTimeout = Duration(seconds: 30);
const privateApiTimeout = Duration(seconds: 30);
const privateApiClientKey = 'privateApiClient';
const publicApiClientKey = 'publicApiClient';
const firebaseApiClientKey = 'firebaseApiClient';

/// Factory for creating Dio clients for different APIs.
@module
abstract class DioModule {
  @Named(publicApiClientKey)
  @lazySingleton
  Dio getPublicApiDioClient() {
    var dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: publicApiTimeout,
    );

    // Add interceptors like public api key, etc.

    return dio;
  }

  @Named(privateApiClientKey)
  @lazySingleton
  Dio getPrivateApiDioClient(Fresh<AuthTokenPair> refreshTokenInterceptor) {
    var dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: privateApiTimeout,
    );

    // Add interceptors like authentication token, etc.
    // final freshTokenInterceptor = _buildFreshTokenInterceptor();
    dio.interceptors.add(refreshTokenInterceptor);
    // dio.interceptors.add(freshTokenInterceptor);

    return dio;
  }

  @Named(firebaseApiClientKey)
  @lazySingleton
  Dio getFirebaseApiDioClient() {
    var dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EnvConfig.firebaseUrl,
    );

    return dio;
  }
}
