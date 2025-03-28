import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'screens/main_screen.dart'; // MainScreenを使用
import 'providers/auth_provider.dart'; // パス修正

// アプリのエントリーポイント
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase初期化成功: ${Firebase.app().name}');
  } catch (e) {
    print('Firebase初期化エラー: $e');
  }

  runApp(
    ProviderScope(
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: AuthWrapper(),
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
          return MainScreen(); // MainScreenを使用
        } else {
          // 簡易ログイン画面（実際のアプリでは専用のログイン画面を使用）
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  // StreamProviderではなくStateNotifierProviderを使用
                  ref.read(authProviderProvider.notifier).signInAnonymously();
                },
                child: Text('ログイン'),
              ),
            ),
          );
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
