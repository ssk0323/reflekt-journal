import 'package:flutter/material.dart';

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
    this.strokeWidth = 4.0,
    this.message,
    this.isOverlay = false,
    this.isCentered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget loadingWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? theme.colorScheme.primary,
            ),
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: theme.textTheme.bodyMedium,
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
