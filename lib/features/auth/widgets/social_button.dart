import 'package:flutter/material.dart';
import '../../../design_system/tokens/index.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback? onPressed;

  const SocialButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: ColorTokens.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: ColorTokens.textPrimary,
              fontSize: TypographyTokens.body,
            ),
          ),
        ],
      ),
    );
  }
}
