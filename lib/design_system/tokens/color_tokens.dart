import 'package:flutter/material.dart';

/// カラーパレットを定義するトークン
class ColorTokens {
  // プライマリカラー
  static const Color primary = Color(0xFFf43f5e); // Rose-500
  static const Color primaryLight = Color(0xFFFEE2E2); // Rose-100

  // テキストカラー
  static const Color textPrimary = Color(0xFF111827); // Gray-900
  static const Color textSecondary = Color(0xFF6B7280); // Gray-500

  // 背景色
  static const Color backgroundPrimary = Color(0xFFFFFFFF); // White
  static const Color backgroundSecondary = Color(0xFFF9FAFB); // Gray-50

  // アクセントカラー
  static const Color accentBlue = Color(0xFF3B82F6); // Blue-500
  static const Color accentYellow = Color(0xFFFBBF24); // Amber-400
  static const Color accentGreen = Color(0xFF10B981); // Emerald-500
  static const Color accentPurple = Color(0xFF8B5CF6); // Violet-500

  // UI要素
  static const Color border = Color(0xFFE5E7EB); // Gray-200
  static const Color shadow = Color(0x1A000000); // rgba(0,0,0,0.1)

  // 状態
  static const Color error = Color(0xFFDC2626); // Red-600
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color info = Color(0xFF3B82F6); // Blue-500
}
