import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final String? tooltip;
  final EdgeInsetsGeometry padding;
  final bool hasBorder;
  final BorderRadius? borderRadius;

  const AppIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.color,
    this.backgroundColor,
    this.size = SizeTokens.iconMd,
    this.tooltip,
    this.padding = const EdgeInsets.all(8.0),
    this.hasBorder = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? Colors.transparent;
    final effectiveColor = color ?? ColorTokens.primary;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(SizeTokens.radiusMd);

    Widget buttonContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: effectiveBorderRadius,
        border: hasBorder
            ? Border.all(
                color: effectiveColor,
                width: 1.0,
              )
            : null,
      ),
      child: Icon(
        icon,
        color: effectiveColor,
        size: size,
      ),
    );

    if (tooltip != null) {
      buttonContent = Tooltip(
        message: tooltip!,
        child: buttonContent,
      );
    }

    return InkWell(
      onTap: onPressed,
      borderRadius: effectiveBorderRadius,
      child: buttonContent,
    );
  }
}
