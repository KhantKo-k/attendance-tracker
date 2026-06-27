import 'package:attendance_tracker/core/error/exceptions.dart';
import 'package:attendance_tracker/core/error/failures.dart';
import 'package:attendance_tracker/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:attendance_tracker/features/localization/presentation/extensions/localization_extension.dart';
import 'package:attendance_tracker/shared/widgets/common_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class GlobalErrorHandler {
  static final GlobalErrorHandler _instance = GlobalErrorHandler._();

  factory GlobalErrorHandler(){
    return _instance;
  }

  GlobalErrorHandler._();

  Future<void>? handleError(BuildContext context, Failure failure,
    {bool isShowErrorIcon = true}) {
      final exception = failure.exception;

      switch(exception) {
        case UnauthorizedException() : 
          return _handleUnauthorized(context, failure);
        case ForbiddenException() :
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseFirestoreAppException(:final code)
            when code == 'permission-denied':
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseStorageAppException(:final code)
            when code == 'unauthorized' || code == 'unauthorized-user':
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseFirestoreAppException(:final code) when code == 'unavailable':
          return _handleMaintenance(context, failure);
        case NetworkException() :
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseAuthAppException(:final code)
            when code == 'network-request-failed':
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case ServiceUnavailableException():
          return _handleMaintenance(context, failure);
        case InternalServerErrorException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case NotFoundException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseFirestoreAppException(:final code) when code == 'not-found':
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseStorageAppException(:final code) when code == 'object-not-found':
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case BadRequestException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case LocationServicesDisabledException():
          return _handleLocationServicesDisabled(context, failure);
        case LocationPermissionDeniedException(:final isPermanent):
          return _handleLocationPermissionDenied(
            context,
            failure,
            isPermanent: isPermanent,
          );
        case AttendanceRuleException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case FirebaseAuthAppException():
        case FirebaseFirestoreAppException():
        case FirebaseStorageAppException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        default: 
          return  _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
      }
    }

    Future<void> _handleFailure( 
      BuildContext context,
      Failure failure, {
        bool isShowErrorIcon = true,
    }) {
      final interpretation = failure.interpretation;

      return CommonDialog.showMessageDialog(
        context: context,
        imagePath: isShowErrorIcon ? "assets/icons/error_icon.png" : null, 
        title: context.trRead(interpretation.title), 
        message: context.trRead(interpretation.message), 
        action: DialogActionData(
          text: context.trRead('common.ok'),
        ),
      );
    }
  
  /// Unauthorized → force logout
  Future<void> _handleUnauthorized( 
    BuildContext context,
    Failure failure,
  ) async {
    final interpretation = failure.interpretation;
    await CommonDialog.showConfirmDialog(
      context: context, 
      title: context.trRead(interpretation.title), 
      message: context.trRead(interpretation.message), 
      confirmText: context.trRead('common.ok'),
    );

    if(!context.mounted) return;

    context.read<AuthBloc>().add(LogoutRequested());
  }

  /// Service Unavailable → show maintenance 
  Future<void> _handleMaintenance( 
    BuildContext context,
    Failure failure,
  ) async {
    final interpretation = failure.interpretation;
    await CommonDialog.showMessageDialog(
      context: context, 
      dismissible: false,
      title: context.trRead(interpretation.title), 
      message: context.trRead(interpretation.message), 
      action: DialogActionData(
        text: context.trRead('common.ok'),
        callback: () {
          SystemNavigator.pop(animated: true);
        }
      )
    );
  }

  Future<void> _handleLocationServicesDisabled(
    BuildContext context,
    Failure failure,
  ) async {
    final interpretation = failure.interpretation;
    final openSettings = await CommonDialog.showConfirmDialog(
      context: context,
      title: context.trRead(interpretation.title),
      message: context.trRead(interpretation.message),
      confirmText: context.trRead('failures.location.openSettings'),
      cancelText: context.trRead('failures.location.cancel'),
    );

    if (openSettings) {
      await Geolocator.openLocationSettings();
    }
  }

  Future<void> _handleLocationPermissionDenied(
    BuildContext context,
    Failure failure, {
    required bool isPermanent,
  }) async {
    final interpretation = failure.interpretation;
    final openSettings = await CommonDialog.showConfirmDialog(
      context: context,
      title: context.trRead(interpretation.title),
      message: context.trRead(interpretation.message),
      confirmText: context.trRead('failures.location.openSettings'),
      cancelText: context.trRead('failures.location.cancel'),
    );

    if (openSettings) {
      await Geolocator.openAppSettings();
    }
  }
}