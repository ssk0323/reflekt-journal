import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';
import 'package:reflekt_app/screens/home_screen.dart';
import 'package:reflekt_app/screens/analytics_screen.dart';
import 'package:reflekt_app/screens/profile/profile_screen.dart';
import 'package:reflekt_app/screens/new_entry_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AnalyticsScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    'AI日記',
    '分析',
    'プロフィール',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showNewEntryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewEntryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // メニュー表示 (実際の実装ではDrawerを使用するなど)
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(0, Icons.home, 'ホーム'),
              _buildBottomNavItem(1, Icons.pie_chart, '分析'),
              SizedBox(width: 48), // FABのスペース
              _buildBottomNavItem(2, Icons.person, 'プロフィール'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewEntryScreen,
        child: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
