import 'package:app_starter_kit_bloc/core/di/environments.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/network/retrofit_api_call_adapter.dart';
import 'package:app_starter_kit_bloc/features/auth/auth_urls.dart';
import 'package:app_starter_kit_bloc/features/auth/data/dtos/login_request.dart';
import 'package:app_starter_kit_bloc/features/auth/data/dtos/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

abstract interface class AuthApiInterface {
  Future<Either<LoginResponse, Failure>> login(LoginRequest request);
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: AuthApiInterface)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class AuthApi implements AuthApiInterface {
  @factoryMethod
  factory AuthApi(@Named(publicApiClientKey) Dio dio) = _AuthApi;

  @override
  @POST(AuthUrls.login)
  Future<Either<LoginResponse, Failure>> login(@Body() LoginRequest request);
}

@mockEnv
@Injectable(as: AuthApiInterface)
class MockAuthApi implements AuthApiInterface {
  @override
  Future<Either<LoginResponse, Failure>> login(LoginRequest request) {
    // Mock implementation here
    throw UnimplementedError();
  }
}
