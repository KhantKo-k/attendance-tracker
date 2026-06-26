import 'package:app_starter_kit_bloc/core/di/environments.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/network/retrofit_api_call_adapter.dart';
import 'package:app_starter_kit_bloc/features/localization/data/dtos/localization_dtos.dart';
import 'package:app_starter_kit_bloc/features/localization/localization_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_localization_api.g.dart';

abstract interface class RemoteLocalizationApi {
  Future<Either<LocalizationDto, Failure>> fetchLocalizations(String lang);
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: RemoteLocalizationApi)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class RemoteLocalizationApiImpl implements RemoteLocalizationApi {
  @factoryMethod
  factory RemoteLocalizationApiImpl(@Named(firebaseApiClientKey) Dio dio) =
      _RemoteLocalizationApiImpl;

  @override
  @GET(LocalizationUrls.getLocalization)
  Future<Either<LocalizationDto, Failure>> fetchLocalizations(
    @Path('lang') String lang,
  );
}

@mockEnv
@Injectable(as: RemoteLocalizationApi)
class MockRemoteLocalizationApiImpl implements RemoteLocalizationApi {
  @override
  Future<Either<LocalizationDto, Failure>> fetchLocalizations(String lang) {
    return Future.value(Left(LocalizationDto(data: {'test': 'test'})));
  }
}
