import 'package:attendance_tracker/core/error/error_reporter.dart';
import 'package:attendance_tracker/core/error/exception_factory.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:retrofit/retrofit.dart';

class RetrofitApiCallAdapter<T>
    extends CallAdapter<Future<T>, Future<Either<T, Failure>>> {
  @override
  Future<Either<T, Failure>> adapt(Future<T> Function() call) async {
    try {
      return Left(await call());
    } catch (e, s) {
      final appException = AppExceptionFactory.identifyException(e, s);
      ErrorReporter().reportException(appException);
      return Right(Failure(exception: appException));
    }
  }
}
