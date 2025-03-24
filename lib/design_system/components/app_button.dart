import 'package:flutter/material.dart';
import '../tokens/index.dart';

enum AppButtonType { primary, secondary, text }

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
  final double? borderRadius;

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
    this.borderRadius,
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
        padding = EdgeInsets.symmetric(
          horizontal: SizeTokens.spacingSm,
          vertical: SizeTokens.spacingXs,
        );
        fontSize = TypographyTokens.small;
        height = SizeTokens.buttonHeight - 8;
        break;
      case AppButtonSize.large:
        padding = EdgeInsets.symmetric(
          horizontal: SizeTokens.spacingLg,
          vertical: SizeTokens.spacingMd,
        );
        fontSize = TypographyTokens.h3;
        height = SizeTokens.buttonLargeHeight;
        break;
      case AppButtonSize.medium:
      default:
        padding = EdgeInsets.symmetric(
          horizontal: SizeTokens.spacingMd,
          vertical: SizeTokens.spacingSm,
        );
        fontSize = TypographyTokens.body;
        height = SizeTokens.buttonHeight;
    }

    // デフォルトのボーダーラディウスを設定
    final effectiveBorderRadius = borderRadius ?? SizeTokens.radiusXl;

    // ボタンタイプに応じたスタイル設定
    Widget buttonChild;
    ButtonStyle buttonStyle;

    switch (type) {
      case AppButtonType.primary:
        buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: ColorTokens.primary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          elevation: 0,
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
      case AppButtonType.secondary:
        buttonStyle = OutlinedButton.styleFrom(
          foregroundColor: ColorTokens.primary,
          padding: padding,
          side: const BorderSide(color: ColorTokens.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          minimumSize: Size(isFullWidth ? double.infinity : 0, height),
        );
        break;
      case AppButtonType.text:
        buttonStyle = TextButton.styleFrom(
          foregroundColor: ColorTokens.primary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
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
            type == AppButtonType.primary ? Colors.white : ColorTokens.primary,
          ),
        ),
      );
    } else {
      // テキストスタイルの設定
      final textStyle = TextStyle(
        fontSize: fontSize,
        fontWeight: TypographyTokens.medium,
      );

      List<Widget> rowChildren = [];

      if (leadingIcon != null) {
        rowChildren.add(Icon(leadingIcon, size: fontSize + 4));
        rowChildren.add(SizedBox(width: SizeTokens.spacingSm));
      }

      rowChildren.add(Text(text, style: textStyle));

      if (trailingIcon != null) {
        rowChildren.add(SizedBox(width: SizeTokens.spacingSm));
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
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: buttonChild,
        );
      case AppButtonType.secondary:
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
