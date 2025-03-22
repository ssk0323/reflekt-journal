import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ユーザーのコレクションへの参照
  CollectionReference get usersCollection => _firestore.collection('users');

  // 日記エントリーのコレクションへの参照
  CollectionReference diaryEntriesCollection(String userId) {
    return usersCollection.doc(userId).collection('diary_entries');
  }

  // ユーザープロファイルの作成/更新
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await usersCollection.doc(userId).set(data, SetOptions(merge: true));
    } catch (e) {
      print('ユーザープロファイル更新失敗: $e');
      rethrow;
    }
  }

  // 日記エントリーの作成
  Future<DocumentReference> createDiaryEntry(
      String userId, Map<String, dynamic> data) async {
    try {
      return await diaryEntriesCollection(userId).add(data);
    } catch (e) {
      print('日記エントリー作成失敗: $e');
      rethrow;
    }
  }

  // 日記エントリーの更新
  Future<void> updateDiaryEntry(
      String userId, String entryId, Map<String, dynamic> data) async {
    try {
      await diaryEntriesCollection(userId).doc(entryId).update(data);
    } catch (e) {
      print('日記エントリー更新失敗: $e');
      rethrow;
    }
  }

  // 日記エントリーの削除
  Future<void> deleteDiaryEntry(String userId, String entryId) async {
    try {
      await diaryEntriesCollection(userId).doc(entryId).delete();
    } catch (e) {
      print('日記エントリー削除失敗: $e');
      rethrow;
    }
  }

  // ユーザーの全日記エントリーを取得
  Stream<QuerySnapshot> getDiaryEntries(String userId) {
    return diaryEntriesCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // 特定の日記エントリーを取得
  Future<DocumentSnapshot> getDiaryEntry(String userId, String entryId) {
    return diaryEntriesCollection(userId).doc(entryId).get();
  }
}
