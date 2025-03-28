import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<User?> {
  final FirebaseAuth _auth;

  AuthNotifier()
      :
        // 明示的に同じFirebaseAuthインスタンスを使用
        _auth = FirebaseAuth.instance,
        super(FirebaseAuth.instance.currentUser) {
    _auth.authStateChanges().listen((User? user) {
      state = user;
    });
  }

  bool get isAuthenticated => state != null;

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('ログアウト成功');
    } catch (e) {
      print('ログアウトエラー: $e');
      rethrow;
    }
  }

  // 匿名ログインを追加（開発・テスト用）
  Future<UserCredential> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      print('匿名ログイン成功: ${credential.user?.uid}');
      return credential;
    } catch (e) {
      print('匿名ログインエラー: $e');
      rethrow;
    }
  }

  // メールとパスワードによるログイン（必要に応じて）
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      print('ログイン開始: $email');
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(
          'ログイン成功: ${credential.user?.uid} / ユーザーメール: ${credential.user?.email}');
      return credential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      // エラーコードに基づいた具体的なメッセージ
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'メールアドレスまたはパスワードが正しくありません';
          break;
        case 'user-not-found':
          errorMessage = 'このメールアドレスのユーザーが見つかりません';
          break;
        case 'wrong-password':
          errorMessage = 'パスワードが正しくありません';
          break;
        case 'user-disabled':
          errorMessage = 'このアカウントは無効化されています';
          break;
        case 'too-many-requests':
          errorMessage = 'ログイン試行回数が多すぎます。しばらく時間をおいてください';
          break;
        default:
          errorMessage = 'ログインに失敗しました: ${e.message}';
      }
      print(errorMessage);
      rethrow;
    } catch (e) {
      print('予期しないログインエラー: $e');
      rethrow;
    }
  }
}

final authProviderProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});

// StreamProviderを追加（状態監視用）
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
