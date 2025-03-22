import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 現在のユーザーを取得
  User? get currentUser => _auth.currentUser;

  // ユーザーの状態変更を監視するStream
  Stream<User?> get userChanges => _auth.authStateChanges();

  // 匿名ログイン
  Future<User?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('匿名ログイン失敗: $e');
      return null;
    }
  }

  // メールとパスワードでログイン
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('メールログイン失敗: $e');
      return null;
    }
  }

  // メールとパスワードで新規登録
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('新規登録失敗: $e');
      return null;
    }
  }

  // ログアウト
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('ログアウト失敗: $e');
    }
  }
}
