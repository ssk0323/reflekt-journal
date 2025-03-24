import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum AppButtonType { primary, secondary, text, outlined }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isFullWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isFullWidth = false,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // サイズに基づくパディングとフォントサイズの設定
    EdgeInsetsGeometry padding;
    double fontSize;
    double height;

    switch (size) {
      case AppButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        fontSize = AppTheme.labelLarge;
        height = 32;
        break;
      case AppButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
        fontSize = AppTheme.titleLarge;
        height = 56;
        break;
      case AppButtonSize.medium:
      default:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        fontSize = AppTheme.bodyLarge;
        height = 48;
    }

    // ボタンタイプに応じたスタイル設定
    Widget buttonChild;
    ButtonStyle buttonStyle;

    switch (type) {
      case AppButtonType.primary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
      case AppButtonType.secondary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
      case AppButtonType.outlined:
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          padding: padding,
          side: BorderSide(color: theme.colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
      case AppButtonType.text:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
    }

    // ボタンの内容（テキスト、アイコン、ローディング）の設定
    if (isLoading) {
      buttonChild = SizedBox(
        height: fontSize,
        width: fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == AppButtonType.primary || type == AppButtonType.secondary
                ? Colors.white
                : theme.colorScheme.primary,
          ),
        ),
      );
    } else {
      // テキストスタイルの設定
      final textStyle = TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      );

      List<Widget> rowChildren = [];

      if (leadingIcon != null) {
        rowChildren.add(Icon(leadingIcon, size: fontSize + 4));
        rowChildren.add(const SizedBox(width: 8));
      }

      rowChildren.add(Text(text, style: textStyle));

      if (trailingIcon != null) {
        rowChildren.add(const SizedBox(width: 8));
        rowChildren.add(Icon(trailingIcon, size: fontSize + 4));
      }

      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      );
    }

    // ボタンタイプに応じたウィジェットの返却
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonChild,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonChild,
        );
      case AppButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonChild,
        );
    }
  }
}
