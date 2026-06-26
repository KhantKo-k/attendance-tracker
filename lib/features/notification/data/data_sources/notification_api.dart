import 'package:app_starter_kit_bloc/core/di/environments.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/network/dio_module.dart';
import 'package:app_starter_kit_bloc/core/network/retrofit_api_call_adapter.dart';
import 'package:app_starter_kit_bloc/features/notification/data/dtos/notification_dtos.dart';
import 'package:app_starter_kit_bloc/features/notification/notification_urls.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/foundation.dart';

part 'notification_api.g.dart';

abstract interface class NotificationApi {
  Future<Either<NotificationListDto, Failure>> getNotifications({
    required String type,
    required int page,
    required int limit,
  });
}

@prodEnv
@devEnv
@uatEnv
@preprodEnv
@Injectable(as: NotificationApi)
@RestApi(parser: Parser.FlutterCompute, callAdapter: RetrofitApiCallAdapter)
abstract class NotificationApiImpl implements NotificationApi {
  @factoryMethod
  factory NotificationApiImpl(@Named(privateApiClientKey) Dio dio) = _NotificationApiImpl;

  @override
  @GET(NotificationUrls.getNotifications)
  Future<Either<NotificationListDto, Failure>> getNotifications({
    @Query('type') required String type,
    @Query('page') required int page,
    @Query('limit') required  int limit,
  });
}

@mockEnv
@Injectable(as: NotificationApi)
class MockNotificationApiImpl implements NotificationApi {
  @override
  Future<Either<NotificationListDto, Failure>> getNotifications({
    required String type,
    required int page,
    required int limit,
  }) {
    return Future.value(Left(NotificationListDto(notifications: [], total: 0, page: page, limit: limit)));
  }
}