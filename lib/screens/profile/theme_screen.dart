import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String _selectedTheme = 'default';
  bool _useSystemSettings = true;

  final List<Map<String, dynamic>> _themes = [
    {'id': 'default', 'name': 'デフォルト', 'color': Colors.blue},
    {'id': 'nature', 'name': '自然', 'color': Colors.green},
    {'id': 'sunset', 'name': '夕暮れ', 'color': Colors.orange},
    {'id': 'ocean', 'name': '海', 'color': Colors.cyan},
    {'id': 'calm', 'name': '落ち着き', 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('テーマ設定'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _themes.length,
              itemBuilder: (context, index) {
                final theme = _themes[index];
                return _buildThemeCard(
                  id: theme['id'],
                  name: theme['name'],
                  color: theme['color'],
                );
              },
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading:
                    Icon(Icons.brightness_auto, color: AppColors.textSecondary),
                title: Text('システム設定に合わせる'),
                trailing: Switch(
                  value: _useSystemSettings,
                  onChanged: (value) {
                    setState(() {
                      _useSystemSettings = value;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard({
    required String id,
    required String name,
    required Color color,
  }) {
    final isSelected = _selectedTheme == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = id;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 8),
            Text(name),
            if (isSelected) ...[
              SizedBox(height: 4),
              Icon(Icons.check_circle, color: AppColors.primary, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}
