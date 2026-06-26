import 'package:app_starter_kit_bloc/core/di/environments.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/network/retrofit_api_call_adapter.dart';
import 'package:app_starter_kit_bloc/features/experiment/data/dtos/mock_response.dart';
import 'package:app_starter_kit_bloc/features/experiment/mock_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'mock_api.g.dart';

abstract interface class MockApiInterface {
  Future<Either<MockResponse, Failure>> request();
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: MockApiInterface)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class MockApi implements MockApiInterface {
  @factoryMethod
  factory MockApi(@Named(publicApiClientKey) Dio dio) = _MockApi;

  @override
  @POST(MockUrls.request)
  Future<Either<MockResponse, Failure>> request();
}

@mockEnv
@Injectable(as: MockApiInterface)
class MockMockApi implements MockApiInterface {
  @override
  Future<Either<MockResponse, Failure>> request() {
    throw UnimplementedError();
  }
}
