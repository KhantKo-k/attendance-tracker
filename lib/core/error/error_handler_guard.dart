import 'package:app_starter_kit_bloc/core/error/error_reporter.dart';
import 'package:app_starter_kit_bloc/core/error/exception_factory.dart';
import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class ErrorHandlerGuard {
  static Future<Either<T, Failure>> on<T>(Future<T> Function() fn) async {
    try {
      return Left(await fn());
    } catch (e, s) {
      final appException = e is AppException
          ? e
          : AppExceptionFactory.identifyException(e, s);
      ErrorReporter().reportException(appException);
      return Right(Failure(exception: appException));
    }
  }
}

extension EitherGuardExtension on Either {
  Either<D, Failure> guardedParse<D, T>(D Function(T value) fn) {
    return fold((value) {
      try {
        return Left(fn(value));
      } catch (e, s) {
        final appException = AppExceptionFactory.identifyException(e, s);
        ErrorReporter().reportException(appException);
        return Right(Failure(exception: appException));
      }
    }, (failure) => Right(failure));
  }
}
