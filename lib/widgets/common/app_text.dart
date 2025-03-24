import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool selectable;
  final double? textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  const AppText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.selectable = false,
    this.textScaleFactor,
    this.color,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.bodyMedium;

    final effectiveStyle = (style ?? defaultStyle)?.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );

    if (selectable) {
      return SelectableText(
        text,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        textScaleFactor: textScaleFactor,
      );
    }

    return Text(
      text,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow : null,
      textScaleFactor: textScaleFactor,
    );
  }

  // ヘッダー用ファクトリーメソッド
  factory AppText.displayLarge(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: 34,
      );

  factory AppText.displayMedium(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: 28,
      );

  factory AppText.heading(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: 22,
      );

  factory AppText.subheading(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: 18,
      );

  factory AppText.title(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: 16,
      );

  factory AppText.body(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight,
        fontSize: 14,
      );

  factory AppText.small(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color,
        fontWeight: fontWeight,
        fontSize: 12,
      );

  factory AppText.caption(
    String text, {
    Key? key,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.clip,
    bool selectable = false,
    double? textScaleFactor,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      AppText(
        text,
        key: key,
        style: TextStyle(),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? Colors.grey,
        fontWeight: fontWeight,
        fontSize: 10,
      );
}
