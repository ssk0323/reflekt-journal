import 'package:flutter/material.dart';
import '../theme/theme_showcase.dart';
import 'firebase_test_screen.dart';
import '../design_system/components/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Nikki',
        showBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Reflekt App',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AppButton(
                text: 'テーマとUIコンポーネント',
                type: AppButtonType.primary,
                isFullWidth: true,
                leadingIcon: Icons.color_lens,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeShowcase(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Firebase テスト',
                type: AppButtonType.secondary,
                isFullWidth: true,
                leadingIcon: Icons.cloud,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirebaseTestScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          // タブの切り替え処理を実装
        },
        items: const [
          AppBottomNavigationItem(
            label: 'ホーム',
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
          ),
          AppBottomNavigationItem(
            label: '作成',
            icon: Icons.add_circle_outline,
            activeIcon: Icons.add_circle,
          ),
          AppBottomNavigationItem(
            label: '統計',
            icon: Icons.bar_chart_outlined,
            activeIcon: Icons.bar_chart,
          ),
          AppBottomNavigationItem(
            label: '設定',
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
