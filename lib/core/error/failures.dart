import 'package:app_starter_kit_bloc/core/error/exceptions.dart';

class Failure {
  final AppException exception;

  final FailureInterpretation interpretation;

  Failure({required this.exception})
    : interpretation = FailureInterpretationHelper().getInterpretation(
        exception,
      );
}

class FailureInterpretation {
  final String title;
  final String message;

  FailureInterpretation({required this.title, required this.message});
}

class FailureInterpretationHelper {
  FailureInterpretation getInterpretation(AppException exception) {
    switch (exception) {
      case BadRequestException():
        return fromBadRequest(exception);
      case UnauthorizedException():
        return fromUnauthorized(exception);
      case ForbiddenException():
        return fromForbidden(exception);
      case NotFoundException():
        return fromNotFound(exception);
      case InternalServerErrorException():
        return fromInternalServerError(exception);
      case ServiceUnavailableException():
        return fromServiceUnavailable(exception);
      case NetworkException():
        return fromNetwork(exception);
      case FirebaseAuthAppException():
        return fromFirebaseAuth(exception);
      case FirebaseFirestoreAppException():
        return fromFirebaseFirestore(exception);
      case FirebaseStorageAppException():
        return fromFirebaseStorage(exception);
      case LocationServicesDisabledException():
        return fromLocationServicesDisabled();
      case LocationPermissionDeniedException(:final isPermanent):
        return fromLocationPermissionDenied(isPermanent);
      case AttendanceRuleException(:final violation):
        return fromAttendanceRule(violation);
      default:
        return fromUnexpected(exception);
    }
  }

  FailureInterpretation fromBadRequest(BadRequestException exception) {
    return FailureInterpretation(
      title: "failures.badRequest.title",
      message: "failures.badRequest.message",
    );
  }

  FailureInterpretation fromUnauthorized(UnauthorizedException exception) {
    return FailureInterpretation(
      title: "failures.unauthorized.title",
      message: "failures.unauthorized.message",
    );
  }

  FailureInterpretation fromForbidden(ForbiddenException exception) {
    return FailureInterpretation(
      title: "failures.forbidden.title",
      message: "failures.forbidden.message",
    );
  }

  FailureInterpretation fromNotFound(NotFoundException exception) {
    return FailureInterpretation(
      title: "failures.notFound.title",
      message: "failures.notFound.message",
    );
  }

  FailureInterpretation fromInternalServerError(
    InternalServerErrorException exception,
  ) {
    return FailureInterpretation(
      title: "failures.internalServerError.title",
      message: "failures.internalServerError.message",
    );
  }

  FailureInterpretation fromServiceUnavailable(
    ServiceUnavailableException exception,
  ) {
    return FailureInterpretation(
      title: "failures.serviceUnavailable.title",
      message:
          "failures.serviceUnavailable.message",
    );
  }

  FailureInterpretation fromNetwork(NetworkException exception) {
    return FailureInterpretation(
        title: "failures.network.title",
      message: "failures.network.message",
    );
  }

  FailureInterpretation fromFirebaseAuth(FirebaseAuthAppException exception) {
    return switch (exception.code) {
      'invalid-email' => FailureInterpretation(
        title: 'failures.firebaseAuth.invalidEmail.title',
        message: 'failures.firebaseAuth.invalidEmail.message',
      ),
      'user-disabled' => FailureInterpretation(
        title: 'failures.firebaseAuth.userDisabled.title',
        message: 'failures.firebaseAuth.userDisabled.message',
      ),
      'user-not-found' => FailureInterpretation(
        title: 'failures.firebaseAuth.userNotFound.title',
        message: 'failures.firebaseAuth.userNotFound.message',
      ),
      'wrong-password' || 'invalid-credential' => FailureInterpretation(
        title: 'failures.firebaseAuth.invalidCredential.title',
        message: 'failures.firebaseAuth.invalidCredential.message',
      ),
      'email-already-in-use' => FailureInterpretation(
        title: 'failures.firebaseAuth.emailAlreadyInUse.title',
        message: 'failures.firebaseAuth.emailAlreadyInUse.message',
      ),
      'operation-not-allowed' => FailureInterpretation(
        title: 'failures.firebaseAuth.operationNotAllowed.title',
        message: 'failures.firebaseAuth.operationNotAllowed.message',
      ),
      'weak-password' => FailureInterpretation(
        title: 'failures.firebaseAuth.weakPassword.title',
        message: 'failures.firebaseAuth.weakPassword.message',
      ),
      'too-many-requests' => FailureInterpretation(
        title: 'failures.firebaseAuth.tooManyRequests.title',
        message: 'failures.firebaseAuth.tooManyRequests.message',
      ),
      'network-request-failed' => FailureInterpretation(
        title: 'failures.network.title',
        message: 'failures.network.message',
      ),
      _ => FailureInterpretation(
        title: 'failures.firebaseAuth.default.title',
        message: 'failures.firebaseAuth.default.message',
      ),
    };
  }

  FailureInterpretation fromFirebaseFirestore(
    FirebaseFirestoreAppException exception,
  ) {
    return switch (exception.code) {
      'permission-denied' => FailureInterpretation(
        title: 'failures.forbidden.title',
        message: 'failures.forbidden.message',
      ),
      'not-found' => FailureInterpretation(
        title: 'failures.notFound.title',
        message: 'failures.notFound.message',
      ),
      'unavailable' => FailureInterpretation(
        title: 'failures.serviceUnavailable.title',
        message: 'failures.serviceUnavailable.message',
      ),
      _ => FailureInterpretation(
        title: 'failures.firebaseFirestore.default.title',
        message: 'failures.firebaseFirestore.default.message',
      ),
    };
  }

  FailureInterpretation fromFirebaseStorage(FirebaseStorageAppException exception) {
    return switch (exception.code) {
      'unauthorized' || 'unauthorized-user' => FailureInterpretation(
        title: 'failures.forbidden.title',
        message: 'failures.forbidden.message',
      ),
      'object-not-found' => FailureInterpretation(
        title: 'failures.notFound.title',
        message: 'failures.notFound.message',
      ),
      'retry-limit-exceeded' || 'canceled' => FailureInterpretation(
        title: 'failures.network.title',
        message: 'failures.network.message',
      ),
      _ => FailureInterpretation(
        title: 'failures.firebaseStorage.default.title',
        message: 'failures.firebaseStorage.default.message',
      ),
    };
  }

  FailureInterpretation fromLocationServicesDisabled() {
    return FailureInterpretation(
      title: 'failures.location.servicesDisabled.title',
      message: 'failures.location.servicesDisabled.message',
    );
  }

  FailureInterpretation fromLocationPermissionDenied(bool isPermanent) {
    if (isPermanent) {
      return FailureInterpretation(
        title: 'failures.location.permissionPermanentlyDenied.title',
        message: 'failures.location.permissionPermanentlyDenied.message',
      );
    }

    return FailureInterpretation(
      title: 'failures.location.permissionDenied.title',
      message: 'failures.location.permissionDenied.message',
    );
  }

  FailureInterpretation fromAttendanceRule(AttendanceRuleViolation violation) {
    return switch (violation) {
      AttendanceRuleViolation.alreadyCheckedIn => FailureInterpretation(
        title: 'failures.attendance.alreadyCheckedIn.title',
        message: 'failures.attendance.alreadyCheckedIn.message',
      ),
      AttendanceRuleViolation.notCheckedIn => FailureInterpretation(
        title: 'failures.attendance.notCheckedIn.title',
        message: 'failures.attendance.notCheckedIn.message',
      ),
      AttendanceRuleViolation.alreadyCheckedInToday => FailureInterpretation(
        title: 'failures.attendance.alreadyCheckedInToday.title',
        message: 'failures.attendance.alreadyCheckedInToday.message',
      ),
      AttendanceRuleViolation.alreadyCheckedOutToday => FailureInterpretation(
        title: 'failures.attendance.alreadyCheckedOutToday.title',
        message: 'failures.attendance.alreadyCheckedOutToday.message',
      ),
    };
  }

  FailureInterpretation fromUnexpected(AppException exception) {
    return FailureInterpretation(
      title: "failures.unexpected.title",
      message: "failures.unexpected.message",
    );
  }
}
