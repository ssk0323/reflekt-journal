import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';
import 'package:reflekt_app/models/user_profile.dart';
import 'package:reflekt_app/screens/profile/profile_edit_screen.dart';
import 'package:reflekt_app/screens/profile/settings_screen.dart';
import 'package:reflekt_app/screens/profile/notifications_screen.dart';
import 'package:reflekt_app/screens/profile/theme_screen.dart';
import 'package:reflekt_app/screens/profile/ai_settings_screen.dart';
import 'package:reflekt_app/screens/profile/data_export_screen.dart';
import 'package:reflekt_app/screens/profile/help_screen.dart';
import 'package:reflekt_app/services/profile_service.dart';
import 'package:reflekt_app/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    _profileFuture = _profileService.getCurrentUserProfile();
  }

  void _navigateToProfileEdit(UserProfile profile) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditScreen(profile: profile),
      ),
    );

    if (result == true) {
      setState(() {
        _loadProfile();
      });
    }
  }

  Widget _buildProfileImage(UserProfile profile) {
    if (profile.photoUrl == null) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.person, size: 36, color: Colors.grey),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipOval(
        child: Image.network(
          '${profile.photoUrl!}&cache=${DateTime.now().millisecondsSinceEpoch}',
          fit: BoxFit.cover,
          errorBuilder: (_, error, stackTrace) {
            return Icon(Icons.person, size: 36, color: Colors.grey);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProviderProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder<UserProfile?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('プロフィール情報が見つかりません'));
          }

          UserProfile profile = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // プロフィールヘッダー
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildProfileImage(profile),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.displayName ?? 'ユーザー名未設定',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '2023年10月から日記を開始',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // プロフィール編集ボタン
                      OutlinedButton.icon(
                        onPressed: () => _navigateToProfileEdit(profile),
                        icon: Icon(Icons.edit),
                        label: Text('プロフィールを編集'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48),
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // 統計情報
                Text(
                  '統計',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildStatCard('127', '記録日数'),
                    SizedBox(width: 8),
                    _buildStatCard('24', '連続日数'),
                    SizedBox(width: 8),
                    _buildStatCard('65%', 'ポジティブ率'),
                  ],
                ),

                SizedBox(height: 24),

                // 設定メニュー
                _buildSettingItem(
                  icon: Icons.settings,
                  title: '設定',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()),
                  ),
                ),

                _buildSettingItem(
                  icon: Icons.notifications,
                  title: '通知',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotificationsScreen()),
                  ),
                ),

                _buildSettingItem(
                  icon: Icons.palette,
                  title: 'テーマ',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ThemeScreen()),
                  ),
                ),

                _buildSettingItem(
                  icon: Icons.psychology,
                  title: 'AI解析設定',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AISettingsScreen()),
                  ),
                ),

                _buildSettingItem(
                  icon: Icons.download,
                  title: 'データのエクスポート',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DataExportScreen()),
                  ),
                ),

                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'ヘルプ',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HelpScreen()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
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
        leading: Icon(icon, color: AppColors.textSecondary, size: 20),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
