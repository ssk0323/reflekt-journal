import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../design_system/tokens/index.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _displayNameController = TextEditingController();
  File? _selectedImage;
  bool _isEditing = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _startEditing() {
    final userProfile = ref.read(profileNotifierProvider).asData?.value;
    if (userProfile != null) {
      _displayNameController.text = userProfile.displayName ?? '';
    }
    setState(() {
      _isEditing = true;
    });
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _selectedImage = null;
    });
  }

  Future<void> _saveChanges() async {
    try {
      await ref.read(profileNotifierProvider.notifier).updateProfile(
            displayName: _displayNameController.text.trim(),
            profileImage: _selectedImage,
          );
      setState(() {
        _isEditing = false;
        _selectedImage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('プロフィールを更新しました')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('プロフィールの更新に失敗しました: ${e.toString()}')),
      );
    }
  }

  Future<void> _signOut() async {
    try {
      await ref.read(authNotifierProvider.notifier).signOut();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ログアウトに失敗しました: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);
    final isLoading = profileState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _startEditing,
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileState.when(
              data: (user) {
                if (user == null) {
                  return const Center(child: Text('プロフィール情報がありません'));
                }
                return _buildProfileContent(
                    user.photoURL, user.displayName, user.email);
              },
              error: (error, stackTrace) => Center(
                child: Text('エラーが発生しました: $error'),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
    );
  }

  Widget _buildProfileContent(
      String? photoUrl, String? displayName, String email) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _isEditing ? _buildEditableAvatar(photoUrl) : _buildAvatar(photoUrl),
          const SizedBox(height: 16),
          if (_isEditing)
            TextField(
              controller: _displayNameController,
              decoration: const InputDecoration(
                labelText: '表示名',
                hintText: '表示名を入力',
                prefixIcon: Icon(Icons.person),
              ),
            )
          else
            Text(
              displayName ?? 'ユーザー',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          const SizedBox(height: 8),
          Text(
            email,
            style: TextStyle(
              fontSize: TypographyTokens.body,
              color: ColorTokens.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          if (_isEditing) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: _cancelEditing,
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('保存'),
                ),
              ],
            ),
          ] else ...[
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('ログアウト'),
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(String? photoUrl) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
      child: photoUrl == null
          ? Icon(
              Icons.person,
              size: 60,
              color: ColorTokens.textSecondary,
            )
          : null,
    );
  }

  Widget _buildEditableAvatar(String? photoUrl) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _selectedImage != null
              ? FileImage(_selectedImage!)
              : (photoUrl != null ? NetworkImage(photoUrl) : null)
                  as ImageProvider?,
          child: (_selectedImage == null && photoUrl == null)
              ? Icon(
                  Icons.person,
                  size: 60,
                  color: ColorTokens.textSecondary,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: ColorTokens.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: _pickImage,
            ),
          ),
        ),
      ],
    );
  }
}
