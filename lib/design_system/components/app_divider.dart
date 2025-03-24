import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color? color;
  final double indent;
  final double endIndent;
  final bool isVertical;

  const AppDivider({
    Key? key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.color,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.isVertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? ColorTokens.border;

    if (isVertical) {
      return Container(
        width: thickness,
        margin: EdgeInsets.only(top: indent, bottom: endIndent),
        height: height,
        color: dividerColor,
      );
    }

    return Divider(
      height: height,
      thickness: thickness,
      color: dividerColor,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
