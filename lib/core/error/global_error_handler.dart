import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/shared/widgets/common_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        case NetworkException() :
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case ServiceUnavailableException():
          return _handleMaintenance(context, failure);
        case InternalServerErrorException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case NotFoundException():
          return _handleFailure(context, failure, isShowErrorIcon: isShowErrorIcon);
        case BadRequestException():
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
          text: "OK",
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
      confirmText: "OK"
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
        text: "OK",
        callback: () {
          SystemNavigator.pop(animated: true);
        }
      )
    );
  }
}