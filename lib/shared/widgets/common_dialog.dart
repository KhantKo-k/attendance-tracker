import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogActionData {
  final String? text;
  final VoidCallback? callback;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool isPrimary;

  const DialogActionData({
    this.text,
    this.callback,
    this.foregroundColor,
    this.backgroundColor,
    this.isPrimary = false,
  });
}

class CommonDialog {
  static Future<void> showMessageDialog({
    required BuildContext context,
    String? imagePath,
    required String title,
    required String message,
    required DialogActionData action,
    bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return PopScope(
          canPop: dismissible,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imagePath != null)
                    FractionallySizedBox(
                      widthFactor: 0.3,
                      child: Image.asset(imagePath),
                    ),
                  imagePath != null
                      ? const SizedBox(height: 16)
                      : const SizedBox.shrink(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                ],
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      action.callback?.call();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                    child: Text(action.text ?? 'OK'),
                  ),
                ),
              ],
              contentPadding: const EdgeInsets.only(
                  left: 16, right: 16, top: 24),
              actionsPadding: const EdgeInsets.only(
                  bottom: 4, top: 4, left: 16, right: 16),
              actionsAlignment: MainAxisAlignment.center,
              shadowColor: Theme.of(context).shadowColor,
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showConfirmDialog({
    required BuildContext context,
    String? imagePath,
    required String title,
    required String message,
    required String confirmText,
    String? cancelText,
    bool dismissible = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imagePath != null)
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: Image.asset(imagePath),
                  ),
                if (imagePath != null) const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cancelText != null)
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.onSurface,
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        child: Text(
                          cancelText,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                      child: Text(
                        confirmText,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            contentPadding:
                const EdgeInsets.only(left: 16, right: 16, top: 24),
            actionsPadding: const EdgeInsets.only(
                bottom: 4, top: 4, left: 16, right: 16),
            actionsAlignment: MainAxisAlignment.center,
            shadowColor: Theme.of(context).shadowColor,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
      },
    );

    return result ?? false;
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const CupertinoActivityIndicator(
            radius: 16,
          ),
        ),
      ),
    );
  }

  static Future<void> showErrorDialog({
    required BuildContext context,
    required String errorTitle,
    required String errorMessage,
    String? errorIconPath,
    VoidCallback? onRetry,
  }) {
    return showMessageDialog(
      context: context,
      imagePath: errorIconPath,
      title: errorTitle,
      message: errorMessage,
      action: DialogActionData(
        text: onRetry != null ? 'Retry' : 'OK',
        callback: onRetry,
      ),
    );
  }

  static Future<void> showMultiActionDialog({
    required BuildContext context,
    String? iconAssetPath,
    required String title,
    required String message,
    required List<DialogActionData> actions,
    bool dismissible = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (iconAssetPath != null)
                  FractionallySizedBox(
                    widthFactor: 0.3,
                    child: Image.asset(iconAssetPath),
                  ),
                if (iconAssetPath != null) const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
                const SizedBox(height: 24),
              ],
            ),
            actions: actions.map((action) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: action.isPrimary
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            action.callback?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: action.foregroundColor ??
                                Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: action.backgroundColor ??
                                Theme.of(context).colorScheme.primary,
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: action.foregroundColor ??
                                  Theme.of(context).colorScheme.primary,
                              width: 1.0,
                            ),
                          ),
                          child:
                              Text(action.text ?? 'OK'),
                        )
                      : TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            action.callback?.call();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: action.foregroundColor ??
                                Theme.of(context).colorScheme.outline,
                            backgroundColor:
                                action.backgroundColor ?? Colors.transparent,
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: action.foregroundColor ??
                                  Theme.of(context).colorScheme.outline,
                              width: 1.0,
                            ),
                          ),
                          child:
                              Text(action.text ?? 'OK'),
                        ),
                ),
              );
            }).toList(),
            contentPadding:
                const EdgeInsets.only(left: 16, right: 16, top: 24),
            actionsPadding: const EdgeInsets.only(
                bottom: 4, top: 4, left: 16, right: 16),
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
      },
    );
  }

  static Future<void> showScrollableDialog({
    required BuildContext context,
    required String title,
    required List<String> messages,
    required DialogActionData action,
    bool dismissible = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 1.43,
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: _buildScrollableContent(context, messages),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(height: 1),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    action.callback?.call();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                    textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  child: Text(action.text ?? 'OK'),
                ),
              ),
            ],
            contentPadding:
                const EdgeInsets.only(left: 16, right: 16, top: 24),
            actionsPadding: const EdgeInsets.only(
                bottom: 4, top: 4, left: 16, right: 16),
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
      },
    );
  }

  static Widget _buildScrollableContent(
    BuildContext context,
    List<String> messages,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var message in messages)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
      ],
    );
  }
}