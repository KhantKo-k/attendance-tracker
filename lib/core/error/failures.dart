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

  FailureInterpretation fromUnexpected(AppException exception) {
    return FailureInterpretation(
      title: "failures.unexpected.title",
      message: "failures.unexpected.message",
    );
  }
}
