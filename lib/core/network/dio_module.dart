import 'package:app_starter_kit_bloc/core/configurations/env_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const publicApiTimeout = Duration(seconds: 30);
const publicApiClientKey = 'publicApiClient';
const firebaseApiClientKey = 'firebaseApiClient';

/// Factory for creating Dio clients for different APIs.
@module
abstract class DioModule {
  @Named(publicApiClientKey)
  @lazySingleton
  Dio getPublicApiDioClient() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EnvConfig.baseUrl,
      connectTimeout: publicApiTimeout,
    );

    return dio;
  }

  @Named(firebaseApiClientKey)
  @lazySingleton
  Dio getFirebaseApiDioClient() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: EnvConfig.firebaseUrl,
    );

    return dio;
  }
}
