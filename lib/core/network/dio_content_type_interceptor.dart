import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class DioContentTypeInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data != null) {
      options.headers.addAll({HttpHeaders.contentTypeHeader: 'application/json'});
    }

    super.onRequest(options, handler);
  }
}
