import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:reflekt_app/services/profile_service.dart';

class ProfileImagePicker extends StatefulWidget {
  final String? currentImageUrl;
  final Function(String) onImageUploaded;

  const ProfileImagePicker({
    Key? key,
    this.currentImageUrl,
    required this.onImageUploaded,
  }) : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ProfileService _profileService = ProfileService();
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  bool _imageError = false;

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      setState(() {
        _isUploading = true;
      });

      dynamic imageData;

      if (kIsWeb) {
        // Web環境での処理
        Uint8List bytes = await pickedFile.readAsBytes();
        imageData = bytes;
      } else {
        // ネイティブ環境での処理
        imageData = io.File(pickedFile.path);
      }

      String? uploadedImageUrl =
          await _profileService.uploadProfileImage(imageData);

      if (uploadedImageUrl != null) {
        widget.onImageUploaded(uploadedImageUrl);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('画像のアップロードに失敗しました: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickAndUploadImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: widget.currentImageUrl != null && !_imageError
                ? ClipOval(
                    child: Image.network(
                      // キャッシュバスター追加
                      '${widget.currentImageUrl!}&cache=${DateTime.now().millisecondsSinceEpoch}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('プロフィール画像読み込みエラー: $error');
                        setState(() {
                          _imageError = true;
                        });
                        return Icon(Icons.person, size: 60, color: Colors.grey);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  )
                : _isUploading
                    ? CircularProgressIndicator()
                    : Icon(Icons.person, size: 60, color: Colors.grey),
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: _pickAndUploadImage,
          child: Text('画像を変更'),
        ),
      ],
    );
  }
}
