import 'package:flutter/material.dart';
import '../tokens/index.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavigationItem> items;

  const AppBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTokens.backgroundPrimary,
        border: Border(
          top: BorderSide(
            color: ColorTokens.border,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorTokens.shadow,
            blurRadius: 8,
            offset: Offset(0, -1),
          ),
        ],
      ),
      height: SizeTokens.tabBarHeight,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorTokens.backgroundPrimary,
        selectedItemColor: ColorTokens.primary,
        unselectedItemColor: ColorTokens.textSecondary,
        selectedLabelStyle: TextStyle(
          fontSize: TypographyTokens.xsmall,
          fontWeight: TypographyTokens.medium,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: TypographyTokens.xsmall,
        ),
        elevation: 0,
        items: items.map((item) => item.toBottomNavigationBarItem()).toList(),
      ),
    );
  }
}

class AppBottomNavigationItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const AppBottomNavigationItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon ?? icon),
      label: label,
    );
  }
}
