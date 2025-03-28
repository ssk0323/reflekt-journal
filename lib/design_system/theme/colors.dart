import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF3B82F6); // blue-500
  static const Color secondary = Color(0xFF10B981); // green-500
  static const Color error = Color(0xFFEF4444); // red-500
  static const Color warning = Color(0xFFF59E0B); // amber-500
  static const Color success = Color(0xFF10B981); // green-500
  static const Color info = Color(0xFF3B82F6); // blue-500

  // Emotion colors
  static const Color happy = Color(0xFFFACC15); // yellow-400
  static const Color neutral = Color(0xFF9CA3AF); // gray-400
  static const Color sad = Color(0xFF60A5FA); // blue-400
  static const Color angry = Color(0xFFF87171); // red-400

  // Text colors
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textDisabled = Color(0xFFD1D5DB); // gray-300

  // Background colors
  static const Color background = Color(0xFFF9FAFB); // gray-50
  static const Color cardBackground = Colors.white;
  static const Color primaryLight = Color(0xFFEFF6FF); // blue-50
  static const Color secondaryLight = Color(0xFFECFDF5); // green-50

  // Border & Divider
  static const Color border = Color(0xFFE5E7EB); // gray-200
  static const Color divider = Color(0xFFE5E7EB); // gray-200

  // MaterialColor for primarySwatch
  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFEFF6FF),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFBFDBFE),
    300: Color(0xFF93C5FD),
    400: Color(0xFF60A5FA),
    500: Color(0xFF3B82F6),
    600: Color(0xFF2563EB),
    700: Color(0xFF1D4ED8),
    800: Color(0xFF1E40AF),
    900: Color(0xFF1E3A8A),
  };
}
