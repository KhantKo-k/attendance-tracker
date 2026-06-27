import 'package:attendance_tracker/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;

class AppExceptionFactory {
  static AppException identifyException(
    dynamic exception,
    StackTrace? stackTrace,
  ) {
    switch (exception) {
      case firebase_auth.FirebaseAuthException():
        return _fromFirebaseAuthException(exception, stackTrace);
      case FirebaseException() when exception.plugin == 'cloud_firestore':
        return _fromFirestoreException(exception, stackTrace);
      case FirebaseException() when exception.plugin == 'firebase_storage':
        return _fromFirebaseStorageException(exception, stackTrace);
      case DioException():
        return _fromDioException(exception, stackTrace);
      case FormatException():
        return _fromFormatException(exception, stackTrace);
      case OutOfMemoryError():
        return _fromOutOfMemoryError(exception, stackTrace);
      case StackOverflowError():
        return _fromStackOverflowError(exception, stackTrace);
      default:
        return _fromUnknownException(exception, stackTrace);
    }
  }

  static AppException _fromFirebaseAuthException(
    firebase_auth.FirebaseAuthException exception,
    StackTrace? stackTrace,
  ) {
    return FirebaseAuthAppException(
      exception: exception,
      stackTrace: stackTrace,
      code: exception.code,
      firebaseMessage: exception.message,
    );
  }

  static AppException _fromFirestoreException(
    FirebaseException exception,
    StackTrace? stackTrace,
  ) {
    return FirebaseFirestoreAppException(
      exception: exception,
      stackTrace: stackTrace,
      code: exception.code,
      firebaseMessage: exception.message,
    );
  }

  static AppException _fromFirebaseStorageException(
    FirebaseException exception,
    StackTrace? stackTrace,
  ) {
    return FirebaseStorageAppException(
      exception: exception,
      stackTrace: stackTrace,
      code: exception.code,
      firebaseMessage: exception.message,
    );
  }

  static AppException _fromDioException(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return _fromDioNetworkException(exception, stackTrace);
      case DioExceptionType.cancel:
        return _fromDioCancleTokenException(exception, stackTrace);
      case DioExceptionType.badResponse:
        return _fromDioBadResponse(exception, stackTrace);
      default:
        return _fromUnknownException(exception, stackTrace);
    }
  }

  static AppException _fromDioBadResponse(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    switch (exception.response?.statusCode) {
      case 400:
        return _fromBadRequest(exception, stackTrace);
      case 401:
        return _fromUnauthorized(exception, stackTrace);
      case 403:
        return _fromForbidden(exception, stackTrace);
      case 404:
        return _fromNotFoundException(exception, stackTrace);
      case 500:
        return _fromInternalServerError(exception, stackTrace);
      case 502:
      case 503:
      case 504:
        return _fromServiceUnavailable(exception, stackTrace);
      default:
        return _fromInternalServerError(exception, stackTrace);
    }
  }

  static AppException _fromBadRequest(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    final requestPayload = exception.requestOptions.data;
    final responsePayload = exception.response?.data;
    return BadRequestException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: requestPayload,
      responsePayload: responsePayload,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromUnauthorized(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return UnauthorizedException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromForbidden(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return ForbiddenException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromNotFoundException(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return NotFoundException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromInternalServerError(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return InternalServerErrorException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
      responsePayload: exception.response?.data,
    );
  }

  static AppException _fromServiceUnavailable(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return ServiceUnavailableException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromDioNetworkException(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return NetworkException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
      type: exception.type,
    );
  }

  static AppException _fromDioCancleTokenException(
    DioException exception,
    StackTrace? stackTrace,
  ) {
    return CancleTokenException(
      exception: exception,
      stackTrace: stackTrace,
      url: exception.response?.realUri.toString() ?? '',
      statusCode: exception.response?.statusCode,
      requestPayload: exception.requestOptions.data,
      requestHeaders: exception.requestOptions.headers,
    );
  }

  static AppException _fromFormatException(
    FormatException exception,
    StackTrace? stackTrace,
  ) {
    return ParseException(exception: exception, stackTrace: stackTrace);
  }

  static AppException _fromOutOfMemoryError(
    OutOfMemoryError exception,
    StackTrace? stackTrace,
  ) {
    return OutOfMemoryErrorException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  static AppException _fromStackOverflowError(
    StackOverflowError exception,
    StackTrace? stackTrace,
  ) {
    return StackOverflowErrorException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  static AppException _fromUnknownException(
    dynamic exception,
    StackTrace? stackTrace,
  ) {
    return UnknownException(exception: exception, stackTrace: stackTrace);
  }
}
