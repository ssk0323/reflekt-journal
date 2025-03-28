import 'package:flutter/material.dart';
import 'package:reflekt_app/models/user_profile.dart';
import 'package:reflekt_app/services/profile_service.dart';
import 'package:reflekt_app/widgets/profile_image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserProfile profile;

  ProfileEditScreen({required this.profile});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileService _profileService = ProfileService();

  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late String? _currentPhotoUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.profile.displayName ?? '');
    _bioController = TextEditingController(text: widget.profile.bio ?? '');
    _currentPhotoUrl = widget.profile.photoUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      UserProfile updatedProfile = widget.profile.copyWith(
        displayName: _nameController.text.trim(),
        bio: _bioController.text.trim(),
        photoUrl: _currentPhotoUrl,
      );

      bool success = await _profileService.updateProfile(updatedProfile);

      if (success) {
        Navigator.pop(context, true); // 成功した場合はtrueを返す
      } else {
        _showErrorMessage('プロフィールの更新に失敗しました');
      }
    } catch (e) {
      _showErrorMessage('エラー: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール編集'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileImagePicker(
                      currentImageUrl: _currentPhotoUrl,
                      onImageUploaded: (String url) {
                        setState(() {
                          _currentPhotoUrl = url;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ユーザー名',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ユーザー名を入力してください';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                        labelText: '自己紹介',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text('保存', style: TextStyle(fontSize: 16)),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
