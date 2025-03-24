import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Center(
        child: userAsyncValue.when(
          data: (user) {
            if (user == null) {
              return const Text('ユーザー情報がありません');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.photoURL != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.photoURL!),
                  )
                else
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                const SizedBox(height: 16),
                Text(
                  'ようこそ、${user.displayName ?? 'ユーザー'}さん',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref.read(authNotifierProvider.notifier).signOut();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ログアウトに失敗しました: $e')),
                      );
                    }
                  },
                  child: const Text('ログアウト'),
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }
}
