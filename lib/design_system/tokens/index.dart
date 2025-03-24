export 'color_tokens.dart';
export 'typography_tokens.dart';
export 'size_tokens.dart';

import 'package:flutter/material.dart';

class ColorTokens {
  static const Color primary = Colors.blue;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color backgroundPrimary = Colors.white;
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color border = Colors.black12;
  static const Color shadow = Colors.black12;
  static const Color error = Colors.red;
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color accentBlue = Color(0xFF2979FF);
  static const Color accentYellow = Color(0xFFFFB300);
}

class TypographyTokens {
  // サイズ
  static const double xsmall = 10.0;
  static const double small = 12.0;
  static const double body = 14.0;
  static const double large = 16.0;
  static const double xlarge = 18.0;
  static const double xxlarge = 20.0;
  static const double h3 = 22.0;
  static const double h2 = 24.0;
  static const double h1 = 28.0;

  // フォントウェイト
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight mediumWeight = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // 行の高さ
  static const double bodyLineHeight = 1.5;
  static const double headingLineHeight = 1.2;

  // フォントファミリー
  static const String primaryFontFamily = 'Roboto';
}

class SizeTokens {
  static const double tabBarHeight = 56.0;
  static const double buttonHeight = 48.0;
  static const double headerHeight = 56.0;
  static const double iconMd = 24.0;

  // 間隔
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;

  // 角丸
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 24.0;
  static const double radiusPill = 9999.0;
}
