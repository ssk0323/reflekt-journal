import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final bool centerTitle;

  const AppHeader({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.leading,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(SizeTokens.headerHeight);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;

    if (leading != null) {
      leadingWidget = leading;
    } else if (showBackButton) {
      leadingWidget = IconButton(
        icon: Icon(Icons.arrow_back, size: SizeTokens.iconMd),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      );
    }

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: ColorTokens.primary,
          fontSize: TypographyTokens.h2,
          fontWeight: TypographyTokens.bold,
        ),
      ),
      leading: leadingWidget,
      actions: actions,
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: ColorTokens.backgroundPrimary,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          color: ColorTokens.border,
          height: 1,
        ),
      ),
    );
  }
}
