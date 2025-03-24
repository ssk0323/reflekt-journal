import 'package:flutter/material.dart';
import '../tokens/index.dart';

/// アプリケーションのテーマ設定を管理するクラス
class AppTheme {
  AppTheme._();

  /// ライトテーマの設定
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ColorTokens.primary,
    scaffoldBackgroundColor: ColorTokens.backgroundPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorTokens.backgroundPrimary,
      foregroundColor: ColorTokens.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: ColorTokens.primary,
        fontSize: TypographyTokens.h2,
        fontWeight: TypographyTokens.bold,
      ),
      iconTheme: IconThemeData(
        color: ColorTokens.textPrimary,
        size: SizeTokens.iconMd,
      ),
      toolbarHeight: SizeTokens.headerHeight,
      shadowColor: ColorTokens.shadow,
    ),
    colorScheme: ColorScheme.light(
      primary: ColorTokens.primary,
      primaryContainer: ColorTokens.primaryLight,
      secondary: ColorTokens.accentBlue,
      secondaryContainer: Color(0xFFDCEBFF), // 薄い青
      tertiary: ColorTokens.accentYellow,
      tertiaryContainer: Color(0xFFFFF4D8), // 薄い黄色
      surface: ColorTokens.backgroundPrimary,
      background: ColorTokens.backgroundSecondary,
      error: ColorTokens.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: ColorTokens.textPrimary,
      onSurface: ColorTokens.textPrimary,
      onBackground: ColorTokens.textPrimary,
      onError: Colors.white,
      outline: ColorTokens.border,
    ),
    fontFamily: TypographyTokens.primaryFontFamily,
    textTheme: TextTheme(
      // 見出し大 (H1)
      displayLarge: TextStyle(
        fontSize: TypographyTokens.h1,
        fontWeight: TypographyTokens.bold,
        color: ColorTokens.textPrimary,
        height: TypographyTokens.headingLineHeight,
      ),
      // 見出し中 (H2)
      displayMedium: TextStyle(
        fontSize: TypographyTokens.h2,
        fontWeight: TypographyTokens.semiBold,
        color: ColorTokens.textPrimary,
        height: TypographyTokens.headingLineHeight,
      ),
      // 見出し小 (H3)
      displaySmall: TextStyle(
        fontSize: TypographyTokens.h3,
        fontWeight: TypographyTokens.mediumWeight,
        color: ColorTokens.textPrimary,
        height: TypographyTokens.headingLineHeight,
      ),
      // 本文
      bodyLarge: TextStyle(
        fontSize: TypographyTokens.body,
        fontWeight: TypographyTokens.regular,
        color: ColorTokens.textPrimary,
        height: TypographyTokens.bodyLineHeight,
      ),
      // 小テキスト
      bodyMedium: TextStyle(
        fontSize: TypographyTokens.small,
        fontWeight: TypographyTokens.regular,
        color: ColorTokens.textPrimary,
        height: TypographyTokens.bodyLineHeight,
      ),
      // 極小テキスト
      bodySmall: TextStyle(
        fontSize: TypographyTokens.xsmall,
        fontWeight: TypographyTokens.regular,
        color: ColorTokens.textSecondary,
        height: TypographyTokens.bodyLineHeight,
      ),
      labelLarge: TextStyle(
        fontSize: TypographyTokens.body,
        fontWeight: TypographyTokens.mediumWeight,
        color: ColorTokens.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: TypographyTokens.small,
        fontWeight: TypographyTokens.mediumWeight,
        color: ColorTokens.textPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: TypographyTokens.xsmall,
        fontWeight: TypographyTokens.mediumWeight,
        color: ColorTokens.textSecondary,
      ),
    ),

    // ボタンテーマ
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorTokens.primary,
        minimumSize: Size(0, SizeTokens.buttonHeight),
        padding: EdgeInsets.symmetric(horizontal: SizeTokens.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeTokens.radiusXl),
        ),
        elevation: 0,
        textStyle: TextStyle(
          fontSize: TypographyTokens.body,
          fontWeight: TypographyTokens.mediumWeight,
          letterSpacing: 0.5,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorTokens.primary,
        side: BorderSide(color: ColorTokens.primary),
        minimumSize: Size(0, SizeTokens.buttonHeight),
        padding: EdgeInsets.symmetric(horizontal: SizeTokens.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeTokens.radiusXl),
        ),
        textStyle: TextStyle(
          fontSize: TypographyTokens.body,
          fontWeight: TypographyTokens.mediumWeight,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorTokens.primary,
        minimumSize: Size(0, SizeTokens.buttonHeight),
        padding: EdgeInsets.symmetric(horizontal: SizeTokens.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        ),
        textStyle: TextStyle(
          fontSize: TypographyTokens.body,
          fontWeight: TypographyTokens.mediumWeight,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // 入力フィールドテーマ
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorTokens.backgroundPrimary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        borderSide: BorderSide(color: ColorTokens.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        borderSide: BorderSide(color: ColorTokens.primary, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        borderSide: BorderSide(color: ColorTokens.border),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        borderSide: BorderSide(color: ColorTokens.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
        borderSide: BorderSide(color: ColorTokens.error, width: 2.0),
      ),
      contentPadding: EdgeInsets.all(SizeTokens.spacingMd),
      hintStyle: TextStyle(
        color: ColorTokens.textSecondary,
        fontSize: TypographyTokens.body,
      ),
      labelStyle: TextStyle(
        color: ColorTokens.textSecondary,
        fontSize: TypographyTokens.body,
      ),
    ),

    // カードテーマ
    cardTheme: CardTheme(
      color: ColorTokens.backgroundPrimary,
      elevation: 1.0,
      shadowColor: ColorTokens.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
      ),
      margin: EdgeInsets.zero,
    ),

    // タブバーテーマ
    tabBarTheme: TabBarTheme(
      labelColor: ColorTokens.primary,
      unselectedLabelColor: ColorTokens.textSecondary,
      indicatorColor: ColorTokens.primary,
      labelStyle: TextStyle(
        fontSize: TypographyTokens.small,
        fontWeight: TypographyTokens.mediumWeight,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: TypographyTokens.small,
        fontWeight: TypographyTokens.regular,
      ),
    ),

    // ボトムナビゲーションバーテーマ
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorTokens.backgroundPrimary,
      selectedItemColor: ColorTokens.primary,
      unselectedItemColor: ColorTokens.textSecondary,
      selectedLabelStyle: TextStyle(
        fontSize: TypographyTokens.xsmall,
        fontWeight: TypographyTokens.mediumWeight,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: TypographyTokens.xsmall,
        fontWeight: TypographyTokens.regular,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
    ),

    // ダイアログテーマ
    dialogTheme: DialogTheme(
      backgroundColor: ColorTokens.backgroundPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
      ),
      elevation: 8.0,
      titleTextStyle: TextStyle(
        fontSize: TypographyTokens.h3,
        fontWeight: TypographyTokens.semiBold,
        color: ColorTokens.textPrimary,
      ),
      contentTextStyle: TextStyle(
        fontSize: TypographyTokens.body,
        color: ColorTokens.textPrimary,
      ),
    ),

    // ディバイダーテーマ
    dividerTheme: DividerThemeData(
      color: ColorTokens.border,
      thickness: 1.0,
      space: SizeTokens.spacingMd,
    ),

    // チップテーマ
    chipTheme: ChipThemeData(
      backgroundColor: ColorTokens.primaryLight,
      disabledColor: ColorTokens.border.withOpacity(0.5),
      selectedColor: ColorTokens.primary,
      padding: EdgeInsets.symmetric(
        horizontal: SizeTokens.spacingMd,
        vertical: SizeTokens.spacingXs,
      ),
      labelStyle: TextStyle(
        fontSize: TypographyTokens.small,
        color: ColorTokens.primary,
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: TypographyTokens.small,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusPill),
      ),
    ),

    // スケルトンスクリーン用のシマーカラー
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorTokens.primary,
      linearMinHeight: 4.0,
    ),

    // スイッチテーマ
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorTokens.primary;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return ColorTokens.primary.withOpacity(0.5);
        }
        return ColorTokens.border;
      }),
    ),

    // スナックバーテーマ
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorTokens.textPrimary,
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: TypographyTokens.body,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );

  /// ダークテーマの設定
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorTokens.primary,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorTokens.primary,
    ),
    elevatedButtonTheme: lightTheme.elevatedButtonTheme,
    outlinedButtonTheme: lightTheme.outlinedButtonTheme,
    inputDecorationTheme: lightTheme.inputDecorationTheme,
  );
}
