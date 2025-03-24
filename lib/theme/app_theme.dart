import 'package:flutter/material.dart';

/// アプリケーションのテーマ設定を管理するクラス
class AppTheme {
  AppTheme._();

  /// カラー定義
  // メインカラー - ダークグレー
  static const Color primaryColor = Color(0xFF424242); // ダークグレー
  static const Color primaryLightColor = Color(0xFF6d6d6d); // ミディアムグレー
  static const Color primaryDarkColor = Color(0xFF1b1b1b); // ほぼブラック

  // アクセントカラー - モスグリーン
  static const Color secondaryColor = Color(0xFF7cb342); // モスグリーン
  static const Color secondaryLightColor = Color(0xFFaee571); // ライトグリーン
  static const Color secondaryDarkColor = Color(0xFF4b830d); // ダークグリーン

  // 背景とサーフェス
  static const Color backgroundColor = Color(0xFFF5F5F5); // ライトグレー
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFC62828); // エラーレッド

  // テキストカラー
  static const Color textPrimaryColor = Color(0xFF212121); // ほぼブラック
  static const Color textSecondaryColor = Color(0xFF757575); // ミディアムグレー
  static const Color textHintColor = Color(0xFFBDBDBD); // ライトグレー

  /// フォント定義
  static const String primaryFontFamily = 'Roboto'; // 必要に応じて変更
  static const String secondaryFontFamily = 'Roboto'; // 必要に応じて変更

  /// フォントサイズ階層
  static const double displayLarge = 34.0;
  static const double displayMedium = 28.0;
  static const double displaySmall = 22.0;
  static const double headlineLarge = 20.0;
  static const double headlineMedium = 18.0;
  static const double titleLarge = 16.0;
  static const double titleMedium = 14.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 10.0;

  /// ライトテーマの設定
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryLightColor,
      secondary: secondaryColor,
      secondaryContainer: secondaryLightColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
    ),
    fontFamily: primaryFontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: displayLarge,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor),
      displayMedium: TextStyle(
          fontSize: displayMedium,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor),
      displaySmall: TextStyle(
          fontSize: displaySmall,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor),
      headlineLarge: TextStyle(
          fontSize: headlineLarge,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor),
      headlineMedium: TextStyle(
          fontSize: headlineMedium,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor),
      titleLarge: TextStyle(
          fontSize: titleLarge,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor),
      titleMedium: TextStyle(
          fontSize: titleMedium,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor),
      bodyLarge: TextStyle(fontSize: bodyLarge, color: textPrimaryColor),
      bodyMedium: TextStyle(fontSize: bodyMedium, color: textPrimaryColor),
      bodySmall: TextStyle(fontSize: bodySmall, color: textSecondaryColor),
      labelLarge: TextStyle(
          fontSize: labelLarge,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor),
      labelMedium: TextStyle(fontSize: labelMedium, color: textSecondaryColor),
      labelSmall: TextStyle(fontSize: labelSmall, color: textSecondaryColor),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: textHintColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: errorColor, width: 2.0),
      ),
      hintStyle: TextStyle(color: textHintColor, fontSize: bodyMedium),
    ),
    cardTheme: CardTheme(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );

  /// ダークテーマの設定
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryLightColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryLightColor,
      primaryContainer: primaryColor,
      secondary: secondaryLightColor,
      secondaryContainer: secondaryColor,
      surface: Color(0xFF121212),
      background: Color(0xFF1E1E1E),
      error: Color(0xFFCF6679),
    ),
    fontFamily: primaryFontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: displayLarge,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      displayMedium: TextStyle(
          fontSize: displayMedium,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      displaySmall: TextStyle(
          fontSize: displaySmall,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: headlineLarge,
          fontWeight: FontWeight.w600,
          color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: headlineMedium,
          fontWeight: FontWeight.w600,
          color: Colors.white),
      titleLarge: TextStyle(
          fontSize: titleLarge,
          fontWeight: FontWeight.w600,
          color: Colors.white),
      titleMedium: TextStyle(
          fontSize: titleMedium,
          fontWeight: FontWeight.w500,
          color: Colors.white),
      bodyLarge: TextStyle(fontSize: bodyLarge, color: Colors.white),
      bodyMedium: TextStyle(fontSize: bodyMedium, color: Colors.white),
      bodySmall: TextStyle(fontSize: bodySmall, color: Colors.white70),
      labelLarge: TextStyle(
          fontSize: labelLarge,
          fontWeight: FontWeight.w500,
          color: Colors.white),
      labelMedium: TextStyle(fontSize: labelMedium, color: Colors.white70),
      labelSmall: TextStyle(fontSize: labelSmall, color: Colors.white70),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryLightColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: primaryLightColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(0xFFCF6679), width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(0xFFCF6679), width: 2.0),
      ),
      hintStyle: TextStyle(color: Colors.grey[500], fontSize: bodyMedium),
    ),
    cardTheme: CardTheme(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );
}
