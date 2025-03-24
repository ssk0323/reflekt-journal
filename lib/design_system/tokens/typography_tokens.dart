import 'package:flutter/material.dart';

/// タイポグラフィを定義するトークン
class TypographyTokens {
  // フォントファミリー
  static const String primaryFontFamily = 'Noto Sans JP';

  // フォントサイズ
  static const double h1 = 20.0; // 見出し大
  static const double h2 = 18.0; // 見出し中
  static const double h3 = 16.0; // 見出し小
  static const double body = 14.0; // 本文
  static const double small = 12.0; // 小テキスト
  static const double xsmall = 10.0; // 極小テキスト

  // 行間
  static const double headingLineHeight = 1.3;
  static const double bodyLineHeight = 1.5;

  // フォントウェイト
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;
}
