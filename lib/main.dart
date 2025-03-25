import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuthのインポートを追加
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'design_system/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/forgot_password_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/profile/screens/profile_screen.dart';

// アプリのエントリーポイント
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase初期化を最もシンプルな方法で行う
  try {
    // デフォルトインスタンスのみを使用
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebaseが初期化されました: ${Firebase.app().name}');

    // 初期化時の既存セッションをクリア（オプショナル）
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // 無視
    }
  } catch (e) {
    print('Firebase初期化エラー: $e');
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Reflekt App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

// 認証状態に基づいて適切な画面を表示するラッパー
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }
}
