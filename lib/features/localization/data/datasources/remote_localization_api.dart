import 'package:attendance_tracker/core/di/environments.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/core/network/dio_module.dart';
import 'package:attendance_tracker/core/network/retrofit_api_call_adapter.dart';
import 'package:attendance_tracker/features/localization/data/dtos/localization_dtos.dart';
import 'package:attendance_tracker/features/localization/localization_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_localization_api.g.dart';

abstract interface class RemoteLocalizationApi {
  Future<Either<LocalizationDto, Failure>> fetchLocalizations(String lang);
}

@productionEnv
@localEnv
@stagingEnv
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
