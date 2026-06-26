import 'package:app_starter_kit_bloc/core/error/exception_factory.dart';
import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/logging/app_logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrorReporter {
  static final ErrorReporter _instance = ErrorReporter._internal();

  factory ErrorReporter() {
    return _instance;
  }

  ErrorReporter._internal();

  void reportException(dynamic exception, [StackTrace? stackTrace]) {
    AppException appException;
    if (exception is! AppException) {
      appException = AppExceptionFactory.identifyException(
        exception,
        stackTrace,
      );
    } else {
      appException = exception;
    }

    if (!kDebugMode) {
      _reportToCrashlytics(appException);
    } else {
      _logToConsole(appException);
    }
  }

  void _logToConsole(AppException exception) {
    final details = exception.toFlutterErrorDetails();
    AppLogger().error(
      "\nAt:\n${details.context} \nSummary:\n${details.summary} \nStack:\n${details.stack}",
    );
  }

  void _reportToCrashlytics(AppException exception) async {
    if (!_shouldReportException(exception)) {
      return;
    }

    final details = exception.toFlutterErrorDetails();
    await FirebaseCrashlytics.instance.recordError(
      details.exception,
      details.stack,
      reason: details.summary.toString(),
      information: [if (details.context != null) details.context.toString()],
    );

    //FlutterError.reportError(exception.toFlutterErrorDetails());
  }

  bool _shouldReportException(AppException exception) {
    return exception.errorIdentity.needsReport;
  }
}
