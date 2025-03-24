import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Webの場合はGoogleクライアントIDが必要
    clientId: kIsWeb
        ? '757279698129-odji681lm2c6bjn75imnnc8upn3mtcrj.apps.googleusercontent.com'
        : null,
  );

  // 現在のユーザー
  User? get currentUser => _auth.currentUser;

  // ユーザー状態の変化を監視するストリーム
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // メールとパスワードでサインアップ
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      print('サインアップ開始: $email');
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Firebaseに認証されました: ${credential.user?.uid}');

      // Firestoreにユーザー情報を保存
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'displayName': credential.user!.displayName,
        'photoURL': credential.user!.photoURL,
      });

      print('Firestoreへのユーザー情報保存に成功しました');

      return credential;
    } catch (e) {
      print('サインアップエラー: $e');
      rethrow;
    }
  }

  // メールとパスワードでログイン
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      print('ログイン開始: $email');
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('ログイン成功: ${credential.user?.uid}');
      return credential;
    } catch (e) {
      print('ログインエラー: $e');
      rethrow;
    }
  }

  // Googleでサインイン
  Future<UserCredential> signInWithGoogle() async {
    try {
      // WebとモバイルでGoogle認証の実装が異なる
      if (kIsWeb) {
        // Webでの実装
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);

        // 新規ユーザーの場合はFirestoreにデータを保存
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': userCredential.user!.email,
            'displayName': userCredential.user!.displayName,
            'photoURL': userCredential.user!.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'provider': 'google',
          });
        }

        return userCredential;
      } else {
        // モバイルでの実装（既存コード）
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) throw Exception('Google sign in was cancelled');

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // 新規ユーザーの場合はFirestoreにデータを保存
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': userCredential.user!.email,
            'displayName': userCredential.user!.displayName,
            'photoURL': userCredential.user!.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'provider': 'google',
          });
        }

        return userCredential;
      }
    } catch (e) {
      print('Google sign in error: $e');
      rethrow;
    }
  }

  // Appleでサインイン
  Future<UserCredential> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);

      // 新規ユーザーの場合はFirestoreにデータを保存
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        String? displayName;

        if (appleCredential.givenName != null &&
            appleCredential.familyName != null) {
          displayName =
              '${appleCredential.givenName} ${appleCredential.familyName}';
        }

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'displayName': displayName ?? userCredential.user!.displayName,
          'photoURL': userCredential.user!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
          'provider': 'apple',
        });
      }

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  // パスワードリセットメールの送信
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // サインアウト
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
