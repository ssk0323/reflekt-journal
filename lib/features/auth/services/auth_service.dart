import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  // コンストラクタ - シンプルに常に同じFirebaseインスタンスを使用
  AuthService() {
    // デフォルトのインスタンスを使用（コンストラクタで遅延初期化はしない）
    print('AuthServiceが初期化されました');
  }

  // 常にデフォルトのFirebaseインスタンスを使用する
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
      print('FirebaseAuth状態: ${_auth.app.name}');
      print(
          'FirebaseAuth初期化確認: ${Firebase.apps.map((app) => app.name).join(', ')}');

      // Firebaseの設定検証
      print('Firebase設定検証');

      if (kIsWeb) {
        print('Web環境でのサインアップ');
      } else {
        print('ネイティブ環境でのサインアップ');
      }

      // 入力値の検証
      if (email.isEmpty || password.isEmpty) {
        throw FirebaseAuthException(
          code: 'invalid-input',
          message: 'メールアドレスまたはパスワードが空です',
        );
      }

      print('Firebase認証を開始します...');
      // 既存のユーザーチェック（オプション）
      try {
        final methods = await _auth.fetchSignInMethodsForEmail(email);
        if (methods.isNotEmpty) {
          print('既存のメールアドレス: $email, 認証方法: $methods');
          throw FirebaseAuthException(
            code: 'email-already-in-use',
            message: 'このメールアドレスは既に使用されています',
          );
        }
      } catch (e) {
        print('メール確認エラー（無視して続行）: $e');
        // 続行（エラーを無視）
      }

      // デフォルトのインスタンスを使用して試してみる
      FirebaseAuth defaultAuth = FirebaseAuth.instance;
      print('デフォルトのFirebaseAuth使用: ${defaultAuth.app.name}');

      UserCredential credential;
      try {
        // 名前付きインスタンスで試行
        credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        print('名前付きインスタンスでエラー発生: $e');
        print('デフォルトインスタンスで再試行します...');

        // デフォルトのインスタンスで再試行
        credential = await defaultAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      print('Firebaseに認証されました: ${credential.user?.uid}');

      // Firestoreにユーザー情報を保存
      if (credential.user != null) {
        try {
          await _firestore.collection('users').doc(credential.user!.uid).set({
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
            'displayName': credential.user!.displayName,
            'photoURL': credential.user!.photoURL,
          });
          print('Firestoreへのユーザー情報保存に成功しました');
        } catch (e) {
          print('Firestoreデータ保存エラー（ユーザー作成は成功）: $e');
          // 続行（エラーを無視）- ユーザーは作成されたがプロフィールデータが保存されなかった
        }
      } else {
        print('ユーザーがnullのため、Firestoreに保存しませんでした');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      print('詳細エラー: ${e.stackTrace}');

      // エラーコードに基づいた処理
      switch (e.code) {
        case 'email-already-in-use':
          print('このメールアドレスは既に使用されています');
          break;
        case 'invalid-email':
          print('メールアドレスの形式が無効です');
          break;
        case 'operation-not-allowed':
          print('この操作は許可されていません - Firebase認証設定を確認してください');
          break;
        case 'weak-password':
          print('パスワードが弱すぎます');
          break;
        case 'internal-error':
          print('Firebaseの内部エラー - Firebase設定を確認してください');
          break;
        default:
          print('予期しないFirebaseAuthエラー: ${e.code}');
      }
      rethrow;
    } catch (e) {
      print('サインアップ中の予期しない例外: $e');
      rethrow;
    }
  }

  // メールとパスワードでログイン - 全面改訂
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      print('ログイン開始: $email');
      print('Firebase App: ${FirebaseAuth.instance.app.name}');

      // 一度サインアウトして既存のセッションをクリア
      try {
        await FirebaseAuth.instance.signOut();
        print('前のセッションをクリアしました');
      } catch (e) {
        print('セッションクリア中のエラー（無視）: $e');
      }

      // 短い遅延を追加して前のセッションがクリアされるのを待つ
      await Future.delayed(const Duration(seconds: 1));

      // 完全にクリーンな状態からログインを試みる
      UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ログイン成功を確認
      if (credential.user != null) {
        print(
            'ログイン成功: ${credential.user?.uid} / ユーザーメール: ${credential.user?.email}');
      } else {
        print('ログインしましたが、ユーザー情報がありません');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');

      // エラーコード別の処理
      switch (e.code) {
        case 'user-not-found':
          print('ユーザーが見つかりません - メールアドレスを確認してください');
          break;
        case 'wrong-password':
          print('パスワードが間違っています');
          break;
        case 'user-disabled':
          print('このアカウントは無効化されています');
          break;
        case 'too-many-requests':
          print('ログイン試行回数が多すぎます。しばらく待ってからお試しください');
          break;
        case 'internal-error':
          print('Firebaseの内部エラー - キャッシュをクリアして再試行してください');
          await FirebaseAuth.instance.signOut(); // セッションをクリア
          break;
        default:
          print('予期しないFirebaseAuthエラー: ${e.code}');
      }
      rethrow;
    } catch (e) {
      print('ログインエラー: $e');
      rethrow;
    }
  }

  // Googleでサインイン
  Future<UserCredential> signInWithGoogle() async {
    try {
      print('Googleサインイン開始...');

      // WebとモバイルでGoogle認証の実装が異なる
      if (kIsWeb) {
        print('Webでのサインイン方法を使用');
        // Webでの実装
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        // スコープの追加（必要に応じて）
        googleProvider
            .addScope('https://www.googleapis.com/auth/userinfo.email');
        googleProvider
            .addScope('https://www.googleapis.com/auth/userinfo.profile');

        // サインイン設定
        googleProvider.setCustomParameters(
            {'login_hint': 'user@example.com', 'prompt': 'select_account'});

        UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);
        print('Googleサインイン成功: ${userCredential.user?.uid}');

        // 新規ユーザーの場合はFirestoreにデータを保存
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          print('新規ユーザーのため、Firestoreにデータを保存');
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
        // モバイルでの実装
        print('モバイルでのサインイン方法を使用');
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          print('Googleサインインがキャンセルされました');
          throw Exception('Google sign in was cancelled');
        }

        print('Googleアカウント選択完了: ${googleUser.email}');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        print('認証情報取得完了、Firebaseにサインイン中...');
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        print('Firebaseサインイン成功: ${userCredential.user?.uid}');

        // 新規ユーザーの場合はFirestoreにデータを保存
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          print('新規ユーザーのため、Firestoreにデータを保存');
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
      print('Googleサインインエラー: $e');
      rethrow;
    }
  }

  // Appleでサインイン
  Future<UserCredential> signInWithApple() async {
    try {
      print('Appleサインイン開始...');

      // プラットフォームごとの処理
      if (kIsWeb) {
        print('Webでのサインイン方法を使用');
        // WEBでのApple認証
        OAuthProvider oAuthProvider = OAuthProvider('apple.com');
        oAuthProvider.setCustomParameters({
          'locale': 'ja_JP',
        });

        return await _auth.signInWithPopup(oAuthProvider);
      } else {
        print('ネイティブでのサインイン方法を使用');
        // サインインに必要なスコープをリクエスト
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        print('Apple認証情報取得完了');

        // Firebaseに必要なcredentialを作成
        final oauthCredential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        print('Firebase用認証情報作成完了');
        UserCredential userCredential =
            await _auth.signInWithCredential(oauthCredential);
        print('Firebaseサインイン成功: ${userCredential.user?.uid}');

        // Appleは初回のみ名前を返却するため、初回サインイン時に名前を保存する必要がある
        // 新規ユーザーの場合はFirestoreにデータを保存
        if (userCredential.additionalUserInfo?.isNewUser ?? false) {
          print('新規ユーザーのため、Firestoreにデータを保存');

          String? displayName;
          if (appleCredential.givenName != null &&
              appleCredential.familyName != null) {
            displayName =
                '${appleCredential.givenName} ${appleCredential.familyName}';
            print('取得した名前: $displayName');
          }

          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': userCredential.user!.email,
            'displayName': displayName ?? userCredential.user!.displayName,
            'photoURL': userCredential.user!.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'provider': 'apple',
          });
        }

        return userCredential;
      }
    } catch (e) {
      print('Appleサインインエラー: $e');
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
