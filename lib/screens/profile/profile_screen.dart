import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reflekt_app/models/user_profile.dart';
import 'package:reflekt_app/screens/profile/profile_edit_screen.dart';
import 'package:reflekt_app/services/profile_service.dart';
import 'package:reflekt_app/providers/auth_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends ConsumerStatefulWidget {
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

  // CORSエラー対応のプロフィール画像ウィジェット
  Widget _buildProfileImage(UserProfile profile) {
    if (profile.photoUrl == null) {
      return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.person, size: 60),
      );
    }

    // キャッシュパラメータを追加
    final cachedUrl =
        '${profile.photoUrl!}&cache=${DateTime.now().millisecondsSinceEpoch}';

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: ClipOval(
        child: Image.network(
          cachedUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, error, stackTrace) {
            print('プロフィール画像エラー: $error');
            return Icon(Icons.person, size: 60, color: Colors.grey);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('マイプロフィール'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              UserProfile? profile = await _profileFuture;
              if (profile != null) {
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
            },
          ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(profile),
                SizedBox(height: 16),
                Text(
                  profile.displayName ?? 'ユーザー名未設定',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(profile.email ?? ''),
                SizedBox(height: 24),
                if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '自己紹介',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(profile.bio!),
                      ],
                    ),
                  ),
                ] else ...[
                  Text('自己紹介は未設定です'),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
