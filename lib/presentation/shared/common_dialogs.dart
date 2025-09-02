import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_grocery/core/extensions/context_extension.dart';
import 'package:online_grocery/presentation/shared/app_button.dart';
import 'package:online_grocery/presentation/theme/color_schemes.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class CommonDialogs {
  static bool isLoading = false;

  static void showLoadingDialog(BuildContext context) {
    if (isLoading) return;
    isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    ).then((_) {
      isLoading = false;
    });
  }

  static void hideLoadingDialog(BuildContext context) {
    if (!isLoading) return;
    Navigator.of(context).pop();
  }

  static void showErrorDialog({
    required BuildContext context,
    String? title,
    String? message,
    VoidCallback? onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColorSchemes.cGrey1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColorSchemes.cWhite, width: 1),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Icon(Icons.warning, size: 32),
              if (title != null) ...[
                const SizedBox(height: 8),
                // Title
                Text(title, style: AppTypography.tBlack18W600),
              ],
              const SizedBox(height: 8),
              // Content
              Text(
                message ?? context.appLocalizations.error_unknown,
                style: AppTypography.tBlack18W600,
              ),
              const SizedBox(height: 32),
              // Buttons
              AppButton(
                content: context.appLocalizations.ok,
                onTap: () {
                  context.pop();
                  onTap?.call();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showWarningDialog({
    required BuildContext context,
    required String message,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
    String? title,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColorSchemes.cWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColorSchemes.cWhite, width: 1),
          ),
          contentPadding: const EdgeInsets.all(16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Icon(Icons.warning, size: 32),
              if (title != null) ...[
                const SizedBox(height: 8),
                // Title
                Text(title, style: AppTypography.tBlack18W600),
              ],
              const SizedBox(height: 8),
              // Content
              Text(message, style: AppTypography.tBlack18W600),
              const SizedBox(height: 32),
              // Buttons
              Row(
                children: [
                  // Cancel button
                  Expanded(
                    child: AppButton(
                      content: cancelText ?? context.appLocalizations.cancel,
                      onTap: () {
                        context.pop();
                        onCancel?.call();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Confirm button
                  Expanded(
                    child: AppButton(
                      content: confirmText ?? context.appLocalizations.confirm,
                      onTap: () {
                        context.pop();
                        onConfirm?.call();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showToast({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: AppColorSchemes.cWhite,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
