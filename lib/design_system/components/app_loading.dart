import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final String? message;
  final bool isOverlay;
  final bool isCentered;

  const AppLoading({
    Key? key,
    this.size = 40.0,
    this.color,
    this.strokeWidth = 3.0,
    this.message,
    this.isOverlay = false,
    this.isCentered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loadingWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? ColorTokens.primary,
            ),
          ),
        ),
        if (message != null) ...[
          SizedBox(height: SizeTokens.spacingMd),
          Text(
            message!,
            style: TextStyle(
              fontSize: TypographyTokens.body,
              color: ColorTokens.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (isOverlay) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeTokens.spacingLg,
            vertical: SizeTokens.spacingMd,
          ),
          decoration: BoxDecoration(
            color: ColorTokens.backgroundPrimary,
            borderRadius: BorderRadius.circular(SizeTokens.radiusMd),
            boxShadow: [
              BoxShadow(
                color: ColorTokens.shadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: loadingWidget,
        ),
      );
    }

    if (isCentered) {
      return Center(child: loadingWidget);
    }

    return loadingWidget;
  }

  // オーバーレイローディングを表示するヘルパーメソッド
  static OverlayEntry showOverlay(
    BuildContext context, {
    String? message,
    Color? color,
  }) {
    final overlayState = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          type: MaterialType.transparency,
          child: AppLoading(
            isOverlay: true,
            message: message,
            color: color,
          ),
        ),
      ),
    );

    overlayState.insert(entry);
    return entry;
  }
}
