import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ユーザーの画像格納パス
  Reference _getUserImagesRef(String userId) {
    return _storage.ref().child('users/$userId/images');
  }

  // 画像のアップロード - ファイルから
  Future<String> uploadImage(String userId, dynamic imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _getUserImagesRef(userId).child(fileName);

      UploadTask uploadTask;

      // Webプラットフォームとモバイルプラットフォームで処理を分ける
      if (kIsWeb) {
        // WebではXFileからbytesを取得する必要がある
        if (imageFile is XFile) {
          final bytes = await imageFile.readAsBytes();
          uploadTask = ref.putData(bytes);
        } else {
          throw Exception('Webプラットフォームではサポートされていない画像形式です');
        }
      } else {
        // モバイルではFileを直接使用
        if (imageFile is File) {
          final fileName =
              '${DateTime.now().millisecondsSinceEpoch}_${path.basename(imageFile.path)}';
          final ref = _getUserImagesRef(userId).child(fileName);
          uploadTask = ref.putFile(imageFile);
        } else {
          throw Exception('モバイルプラットフォームではサポートされていない画像形式です');
        }
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('画像アップロード失敗: $e');
      rethrow;
    }
  }

  // 画像の削除
  Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      print('画像削除失敗: $e');
      rethrow;
    }
  }
}
