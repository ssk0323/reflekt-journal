import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/index.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;
  final String? suffixText;
  final EdgeInsetsGeometry? contentPadding;
  final bool autoFocus;
  final String? helperText;
  final bool enableSuggestions;
  final bool enabled;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;

  const AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.contentPadding,
    this.autoFocus = false,
    this.helperText,
    this.enableSuggestions = true,
    this.enabled = true,
    this.textInputAction,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: errorText != null
                  ? ColorTokens.error
                  : ColorTokens.textPrimary,
            ),
          ),
          SizedBox(height: SizeTokens.spacingSm),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          focusNode: focusNode,
          onTap: onTap,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          autofocus: autoFocus,
          enabled: enabled,
          enableSuggestions: enableSuggestions,
          textAlign: textAlign,
          style: theme.textTheme.bodyLarge?.copyWith(
            color:
                enabled ? ColorTokens.textPrimary : ColorTokens.textSecondary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            helperText: helperText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            prefixText: prefixText,
            suffixText: suffixText,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: SizeTokens.spacingMd,
                    vertical: SizeTokens.spacingMd),
            filled: true,
            fillColor: enabled
                ? ColorTokens.backgroundPrimary
                : ColorTokens.backgroundSecondary,
            errorMaxLines: 2,
            helperMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
