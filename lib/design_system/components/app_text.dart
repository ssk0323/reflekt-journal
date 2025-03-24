import 'package:flutter/material.dart';
import '../tokens/index.dart';

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
  final double? height;

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
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.bodyLarge;

    final effectiveStyle = (style ?? defaultStyle)?.copyWith(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
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

  // ファクトリーメソッド
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.bold,
        fontSize: TypographyTokens.h1,
        height: TypographyTokens.headingLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.semiBold,
        fontSize: TypographyTokens.h2,
        height: TypographyTokens.headingLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.medium,
        fontSize: TypographyTokens.h3,
        height: TypographyTokens.headingLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.medium,
        fontSize: TypographyTokens.body,
        height: TypographyTokens.headingLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.medium,
        fontSize: TypographyTokens.body,
        height: TypographyTokens.bodyLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.regular,
        fontSize: TypographyTokens.body,
        height: TypographyTokens.bodyLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textPrimary,
        fontWeight: fontWeight ?? TypographyTokens.regular,
        fontSize: TypographyTokens.small,
        height: TypographyTokens.bodyLineHeight,
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
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        selectable: selectable,
        textScaleFactor: textScaleFactor,
        color: color ?? ColorTokens.textSecondary,
        fontWeight: fontWeight ?? TypographyTokens.regular,
        fontSize: TypographyTokens.xsmall,
        height: TypographyTokens.bodyLineHeight,
      );
}
