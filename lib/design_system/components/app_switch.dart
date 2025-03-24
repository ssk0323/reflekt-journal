import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;

  const AppSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.label,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveOnChanged = disabled ? null : onChanged;

    Widget switchWidget = SizedBox(
      height: 24,
      child: Switch.adaptive(
        value: value,
        onChanged: effectiveOnChanged,
        activeColor: ColorTokens.primary,
        activeTrackColor: ColorTokens.primaryLight,
      ),
    );

    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          switchWidget,
          SizedBox(width: SizeTokens.spacingSm),
          Text(
            label!,
            style: TextStyle(
              fontSize: TypographyTokens.body,
              color: disabled
                  ? ColorTokens.textSecondary
                  : ColorTokens.textPrimary,
            ),
          ),
        ],
      );
    }

    return switchWidget;
  }
}
