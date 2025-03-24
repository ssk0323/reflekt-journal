import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool hasBorder;
  final Color? borderColor;
  final double borderWidth;

  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.elevation = 1,
    this.color,
    this.borderRadius,
    this.onTap,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = borderRadius ?? BorderRadius.circular(SizeTokens.radiusMd);

    final card = Card(
      margin: margin,
      elevation: elevation,
      shadowColor: ColorTokens.shadow,
      color: color ?? ColorTokens.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: hasBorder
            ? BorderSide(
                color: borderColor ?? ColorTokens.border,
                width: borderWidth,
              )
            : BorderSide.none,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: card,
      );
    }

    return card;
  }
}
