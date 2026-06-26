import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FlutterErrorHandler {
  static void onError(FlutterErrorDetails details) {
    AppLogger().error(
      "At: ${details.context} \n Summary: \n${details.summary} \n Details: \n$details",
    );

    final exception = details.exception;

    if (exception is AppException) {
      FirebaseCrashlytics.instance.recordError(exception, exception.stackTrace,
          fatal: exception.errorIdentity.isSevere, printDetails: false);
    } else {
      FirebaseCrashlytics.instance
          .recordError(details.exception, details.stack, printDetails: false);
    }
  }
}
