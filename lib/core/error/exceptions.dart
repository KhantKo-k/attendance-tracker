import 'package:attendance_tracker/core/error/error_identity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract base class AppException {
  final dynamic exception;
  final StackTrace? stackTrace;
  late final ErrorIdentity errorIdentity;

  AppException({required this.exception, required this.stackTrace}) {
    errorIdentity = buildErrorIdentity();
  }

  @override
  String toString() {
    return errorIdentity.description;
  }

  FlutterErrorDetails toFlutterErrorDetails() {
    return FlutterErrorDetails(
      exception: this,
      stack: _buildRefinedStackTrace(),
    );
  }

  StackTrace _buildRefinedStackTrace() {
    final List<String> lines;

    if (stackTrace == null) {
      lines = [];
    } else {
      final stackTraceString = stackTrace.toString();
      lines = stackTraceString.split('\n');
    }

    // Insert the error title at the beginning of the stack trace to make it categorized
    // based on the error identity in the crashlytics
    lines.insert(
      0,
      "#1     ${errorIdentity.title} (package:your_app/path/file.dart:123:45)",
    );

    final purifiedStackTrace = lines.join('\n');

    return StackTrace.fromString(purifiedStackTrace);
  }

  ErrorIdentity buildErrorIdentity();
}

abstract base class HttpException extends AppException {
  final String url;
  final int? statusCode;
  final Map<String, dynamic> requestHeaders;
  final dynamic requestPayload;

  HttpException({
    required super.exception,
    required super.stackTrace,
    required this.url,
    required this.statusCode,
    required this.requestHeaders,
    required this.requestPayload,
  });
}

final class BadRequestException extends HttpException {
  final dynamic responsePayload;

  BadRequestException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
    required this.responsePayload,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Bad Request',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'request': requestPayload,
        'response': responsePayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class UnauthorizedException extends HttpException {
  UnauthorizedException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Unauthorized',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class ForbiddenException extends HttpException {
  ForbiddenException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Forbidden',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class NotFoundException extends HttpException {
  NotFoundException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Not Found',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class InternalServerErrorException extends HttpException {
  final dynamic responsePayload;

  InternalServerErrorException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
    required this.responsePayload,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Internal Server Error',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'responsePayload': responsePayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class ServiceUnavailableException extends HttpException {
  ServiceUnavailableException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Service Unavailable',
      location: url,
      isSevere: true,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class CancleTokenException extends HttpException {
  CancleTokenException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Cancel Token',
      location: url,
      isSevere: false,
      needsReport: false,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
      },
    );
  }
}

final class NetworkException extends HttpException {
  final DioExceptionType type;
  NetworkException({
    required DioException super.exception,
    required super.stackTrace,
    required super.url,
    required super.statusCode,
    required super.requestPayload,
    required super.requestHeaders,
    required this.type,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Network',
      location: url,
      isSevere: false,
      needsReport: true,
      details: {
        'requestPayload': requestPayload,
        'requestHeaders': requestHeaders,
        'reason': type.name,
      },
    );
  }
}

final class OutOfMemoryErrorException extends AppException {
  OutOfMemoryErrorException({
    required OutOfMemoryError super.exception,
    required super.stackTrace,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Out of Memory',
      location: 'See the stack trace for more details',
      isSevere: false,
      needsReport: true,
      details: {'cause': (exception as OutOfMemoryError).toString()},
    );
  }
}

final class StackOverflowErrorException extends AppException {
  StackOverflowErrorException({
    required StackOverflowError super.exception,
    required super.stackTrace,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Stack Overflow',
      location: 'See the stack trace for more details',
      isSevere: false,
      needsReport: true,
      details: {'cause': (exception as StackOverflowError).toString()},
    );
  }
}

final class ParseException extends AppException {
  ParseException({
    required FormatException super.exception,
    required super.stackTrace,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Parse Error',
      location: 'See the stack trace for more details',
      isSevere: false,
      needsReport: true,
      details: {'cause': (exception as FormatException).toString()},
    );
  }
}

final class FirebaseAuthAppException extends AppException {
  final String code;
  final String? firebaseMessage;

  FirebaseAuthAppException({
    required super.exception,
    required super.stackTrace,
    required this.code,
    required this.firebaseMessage,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Firebase Auth',
      location: code,
      isSevere: _isSevereCode(code),
      needsReport: _needsReport(code),
      details: {
        'code': code,
        if (firebaseMessage != null) 'message': firebaseMessage,
      },
    );
  }

  static bool _isSevereCode(String code) {
    return switch (code) {
      'operation-not-allowed' => true,
      _ => false,
    };
  }

  static bool _needsReport(String code) {
    return switch (code) {
      'invalid-email' ||
      'user-disabled' ||
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' ||
      'email-already-in-use' ||
      'weak-password' ||
      'too-many-requests' ||
      'network-request-failed' => false,
      _ => true,
    };
  }
}

final class FirebaseFirestoreAppException extends AppException {
  final String code;
  final String? firebaseMessage;

  FirebaseFirestoreAppException({
    required super.exception,
    required super.stackTrace,
    required this.code,
    required this.firebaseMessage,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Firestore',
      location: code,
      isSevere: code == 'permission-denied',
      needsReport: code != 'permission-denied',
      details: {
        'code': code,
        if (firebaseMessage != null) 'message': firebaseMessage,
      },
    );
  }
}

final class FirebaseStorageAppException extends AppException {
  final String code;
  final String? firebaseMessage;

  FirebaseStorageAppException({
    required super.exception,
    required super.stackTrace,
    required this.code,
    required this.firebaseMessage,
  });

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Firebase Storage',
      location: code,
      isSevere: false,
      needsReport: !{'unauthorized', 'unauthorized-user', 'object-not-found'}
          .contains(code),
      details: {
        'code': code,
        if (firebaseMessage != null) 'message': firebaseMessage,
      },
    );
  }
}

final class LocationServicesDisabledException extends AppException {
  LocationServicesDisabledException({required super.stackTrace})
    : super(exception: StateError('Location services are disabled'));

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Location Services Disabled',
      location: 'Device location is turned off',
      isSevere: false,
      needsReport: false,
      details: {},
    );
  }
}

final class LocationPermissionDeniedException extends AppException {
  LocationPermissionDeniedException({
    required super.stackTrace,
    required this.isPermanent,
  }) : super(exception: StateError('Location permission denied'));

  final bool isPermanent;

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Location Permission Denied',
      location: isPermanent
          ? 'Permission permanently denied'
          : 'Permission denied',
      isSevere: false,
      needsReport: false,
      details: {'isPermanent': isPermanent},
    );
  }
}

enum AttendanceRuleViolation {
  alreadyCheckedIn,
  notCheckedIn,
  alreadyCheckedInToday,
  alreadyCheckedOutToday,
}

final class AttendanceRuleException extends AppException {
  AttendanceRuleException({
    required this.violation,
    required super.stackTrace,
  }) : super(exception: StateError(violation.name));

  final AttendanceRuleViolation violation;

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: 'Attendance Rule',
      location: violation.name,
      isSevere: false,
      needsReport: false,
      details: {'violation': violation.name},
    );
  }
}

final class UnknownException extends AppException {
  UnknownException({required super.exception, required super.stackTrace});

  @override
  ErrorIdentity buildErrorIdentity() {
    return ErrorIdentity(
      type: exception.runtimeType.toString(),
      location: 'See the stack trace for more details',
      isSevere: false,
      needsReport: true,
      details: {},
    );
  }
}
