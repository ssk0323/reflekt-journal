import 'dart:io' as io;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reflekt_app/models/user_profile.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 現在のユーザープロフィールを取得
  Future<UserProfile?> getCurrentUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return null;

      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserProfile.fromFirestore(doc);
      } else {
        // プロフィールが存在しない場合は新規作成
        UserProfile newProfile = UserProfile(
          id: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
          createdAt: DateTime.now(),
        );
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newProfile.toMap());
        return newProfile;
      }
    } catch (e) {
      print('プロフィール取得エラー: $e');
      return null;
    }
  }

  // プロフィール更新
  Future<bool> updateProfile(UserProfile updatedProfile) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(updatedProfile.toMap());

      // Firebase Authユーザー情報も更新
      if (updatedProfile.displayName != null) {
        await user.updateDisplayName(updatedProfile.displayName);
      }

      if (updatedProfile.photoUrl != null) {
        await user.updatePhotoURL(updatedProfile.photoUrl);
      }

      return true;
    } catch (e) {
      print('プロフィール更新エラー: $e');
      return false;
    }
  }

  // プロフィール画像アップロード - Web対応
  Future<String?> uploadProfileImage(dynamic imageFile) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return null;

      String fileName =
          'profile_${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef =
          _storage.ref().child('profile_images').child(fileName);

      UploadTask uploadTask;

      if (kIsWeb) {
        // Web環境での処理 - メタデータを追加してCORS対応
        SettableMetadata metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': 'profile_image'},
        );

        if (imageFile is Uint8List) {
          uploadTask = storageRef.putData(imageFile, metadata);
        } else {
          uploadTask = storageRef.putBlob(imageFile);
        }
      } else {
        // ネイティブ環境での処理
        uploadTask = storageRef.putFile(imageFile as io.File);
      }

      await uploadTask;

      // ダウンロードURLにはキャッシュバスターを追加
      String downloadUrl = await storageRef.getDownloadURL();
      downloadUrl =
          '$downloadUrl&cache=${DateTime.now().millisecondsSinceEpoch}';

      // プロフィール更新
      await _firestore.collection('users').doc(user.uid).update({
        'photoUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Auth情報も更新
      await user.updatePhotoURL(downloadUrl);

      return downloadUrl;
    } catch (e) {
      print('画像アップロードエラー: $e');
      return null;
    }
  }
}
