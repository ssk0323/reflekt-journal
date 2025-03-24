/// サイズとスペーシングを定義するトークン
class SizeTokens {
  // ベーススペーシング
  static const double base = 8.0;

  // スペーシング
  static const double spacingXs = base * 0.5; // 4px
  static const double spacingSm = base; // 8px
  static const double spacingMd = base * 2; // 16px
  static const double spacingLg = base * 3; // 24px
  static const double spacingXl = base * 4; // 32px

  // コンポーネントのサイズ
  static const double buttonHeight = base * 5; // 40px
  static const double buttonLargeHeight = base * 6; // 48px
  static const double inputHeight = base * 6; // 48px
  static const double headerHeight = base * 7.5; // 60px
  static const double tabBarHeight = base * 7; // 56px

  // ボーダーレディウス
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusPill = 100.0; // ピル形状（カプセル型）

  // アイコンサイズ
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

  // タッチターゲットの最小サイズ
  static const double touchTargetMinimum = 44.0;
}
