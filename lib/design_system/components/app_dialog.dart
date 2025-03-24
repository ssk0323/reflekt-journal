import 'package:flutter/material.dart';
import '../tokens/index.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? contentWidget;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;
  final VoidCallback? onDismissed;
  final bool isDismissible;
  final Widget? icon;

  const AppDialog({
    Key? key,
    required this.title,
    this.content,
    this.contentWidget,
    this.positiveButtonText,
    this.negativeButtonText,
    this.onPositivePressed,
    this.onNegativePressed,
    this.onDismissed,
    this.isDismissible = true,
    this.icon,
  })  : assert(content != null || contentWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (isDismissible) {
          if (onDismissed != null) {
            onDismissed!();
          }
          return true;
        }
        return false;
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        ),
        backgroundColor: ColorTokens.backgroundPrimary,
        child: Padding(
          padding: EdgeInsets.all(SizeTokens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Center(child: icon!),
                SizedBox(height: SizeTokens.spacingMd),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: TypographyTokens.h3,
                  fontWeight: TypographyTokens.semiBold,
                  color: ColorTokens.textPrimary,
                ),
              ),
              SizedBox(height: SizeTokens.spacingMd),
              contentWidget ??
                  Text(
                    content!,
                    style: TextStyle(
                      fontSize: TypographyTokens.body,
                      color: ColorTokens.textPrimary,
                    ),
                  ),
              SizedBox(height: SizeTokens.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (negativeButtonText != null) ...[
                    AppButton(
                      text: negativeButtonText!,
                      type: AppButtonType.text,
                      onPressed: () {
                        if (onNegativePressed != null) {
                          onNegativePressed!();
                        } else {
                          Navigator.of(context).pop(false);
                        }
                      },
                    ),
                    SizedBox(width: SizeTokens.spacingSm),
                  ],
                  if (positiveButtonText != null)
                    AppButton(
                      text: positiveButtonText!,
                      type: AppButtonType.primary,
                      onPressed: () {
                        if (onPositivePressed != null) {
                          onPositivePressed!();
                        } else {
                          Navigator.of(context).pop(true);
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ダイアログを表示するヘルパーメソッド
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? content,
    Widget? contentWidget,
    String? positiveButtonText,
    String? negativeButtonText,
    VoidCallback? onPositivePressed,
    VoidCallback? onNegativePressed,
    VoidCallback? onDismissed,
    bool isDismissible = true,
    Widget? icon,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: content,
        contentWidget: contentWidget,
        positiveButtonText: positiveButtonText,
        negativeButtonText: negativeButtonText,
        onPositivePressed: onPositivePressed,
        onNegativePressed: onNegativePressed,
        onDismissed: onDismissed,
        isDismissible: isDismissible,
        icon: icon,
      ),
    );
  }
}
