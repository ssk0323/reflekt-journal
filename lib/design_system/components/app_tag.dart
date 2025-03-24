import 'package:flutter/material.dart';
import '../tokens/index.dart';

enum TagType { primary, blue, yellow, green, purple }

class AppTag extends StatelessWidget {
  final String text;
  final TagType type;
  final VoidCallback? onTap;
  final bool isSelected;
  final IconData? icon;

  const AppTag({
    Key? key,
    required this.text,
    this.type = TagType.primary,
    this.onTap,
    this.isSelected = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color textColor;

    // タグのタイプに応じた色の設定
    switch (type) {
      case TagType.primary:
        backgroundColor =
            isSelected ? ColorTokens.primary : ColorTokens.primaryLight;
        textColor = isSelected ? Colors.white : ColorTokens.primary;
        break;
      case TagType.blue:
        backgroundColor =
            isSelected ? ColorTokens.accentBlue : Color(0xFFDCEBFF);
        textColor = isSelected ? Colors.white : ColorTokens.accentBlue;
        break;
      case TagType.yellow:
        backgroundColor =
            isSelected ? ColorTokens.accentYellow : Color(0xFFFFF4D8);
        textColor = isSelected
            ? ColorTokens.textPrimary
            : ColorTokens.accentYellow.withOpacity(0.8);
        break;
      case TagType.green:
        backgroundColor =
            isSelected ? ColorTokens.accentGreen : Color(0xFFD1FAE5);
        textColor = isSelected ? Colors.white : ColorTokens.accentGreen;
        break;
      case TagType.purple:
        backgroundColor =
            isSelected ? ColorTokens.accentPurple : Color(0xFFEDE9FE);
        textColor = isSelected ? Colors.white : ColorTokens.accentPurple;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(SizeTokens.radiusPill),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeTokens.spacingMd,
            vertical: SizeTokens.spacingXs,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(SizeTokens.radiusPill),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: TypographyTokens.small,
                  color: textColor,
                ),
                SizedBox(width: SizeTokens.spacingXs),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: TypographyTokens.small,
                  fontWeight: TypographyTokens.medium,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
