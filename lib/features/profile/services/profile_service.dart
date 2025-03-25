import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase クラスの追加
import '../../auth/models/user_model.dart';

class ProfileService {
  // 名前付きFirebaseインスタンスを使用
  final FirebaseAuth _auth = FirebaseAuth.instanceFor(
    app: Firebase.app('ReflektApp'),
  );

  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(
    app: Firebase.app('ReflektApp'),
  );

  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
    app: Firebase.app('ReflektApp'),
  );

  // ユーザープロフィールの取得
  Future<UserModel?> getUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  // プロフィール情報の更新
  Future<void> updateProfile({
    String? displayName,
    File? profileImage,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('ユーザーがログインしていません');

    Map<String, dynamic> updates = {};

    // 表示名の更新
    if (displayName != null) {
      updates['displayName'] = displayName;
      // Firebase Authのプロフィールも更新
      await user.updateDisplayName(displayName);
    }

    // プロフィール画像のアップロード
    if (profileImage != null) {
      final storageRef = _storage.ref().child('profile_images/${user.uid}');
      await storageRef.putFile(profileImage);
      final imageUrl = await storageRef.getDownloadURL();

      updates['photoURL'] = imageUrl;
      // Firebase Authのプロフィールも更新
      await user.updatePhotoURL(imageUrl);
    }

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(user.uid).update(updates);
    }
  }

  // プロフィール画像の削除
  Future<void> deleteProfileImage() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('ユーザーがログインしていません');

    try {
      // Storageから画像を削除
      final storageRef = _storage.ref().child('profile_images/${user.uid}');
      await storageRef.delete();

      // Firestoreの参照を更新
      await _firestore.collection('users').doc(user.uid).update({
        'photoURL': null,
      });

      // Firebase Authのプロフィールも更新
      await user.updatePhotoURL(null);
    } catch (e) {
      print('プロフィール画像の削除中にエラーが発生しました: $e');
      rethrow;
    }
  }
}
