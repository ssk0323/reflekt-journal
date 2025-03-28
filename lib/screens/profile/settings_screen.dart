import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildToggleItem(
              icon: Icons.dark_mode,
              title: 'ダークモード',
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
            // プロフィール編集の項目は削除
            _buildNavigationItem(
              icon: Icons.lock,
              title: 'プライバシー',
              onTap: () {
                // プライバシー設定画面に遷移
              },
            ),
            _buildNavigationItem(
              icon: Icons.share,
              title: '共有設定',
              onTap: () {
                // 共有設定画面に遷移
              },
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(Icons.delete_forever, color: Colors.red),
                title: Text(
                  'アカウント削除',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  // アカウント削除の確認ダイアログ表示
                  _showDeleteAccountDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textSecondary),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('アカウントを削除しますか？'),
        content: Text('この操作は取り消せません。すべてのデータが削除されます。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              // アカウント削除処理
              Navigator.pop(context);
            },
            child: Text('削除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
