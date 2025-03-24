import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_button.dart';
import '../../../design_system/tokens/index.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ref.read(authNotifierProvider.notifier).signInWithEmail(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ログインに失敗しました: ${e.toString()}')),
        );
      }
    }
  }

  void _signInWithGoogle() async {
    try {
      print('Googleログイン開始');
      await ref.read(authNotifierProvider.notifier).signInWithGoogle();
      print('Googleログイン成功');
    } catch (e) {
      print('Googleログインエラー: $e');
      String errorMessage = 'Googleログインに失敗しました';

      if (e.toString().contains('popup')) {
        errorMessage = 'ポップアップがブロックされています。ブラウザの設定を確認してください。';
      } else if (e.toString().contains('network')) {
        errorMessage = 'ネットワーク接続エラーが発生しました。インターネット接続を確認してください。';
      } else if (e.toString().contains('cancelled')) {
        errorMessage = 'ログインがキャンセルされました。';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  void _signInWithApple() async {
    try {
      await ref.read(authNotifierProvider.notifier).signInWithApple();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appleログインに失敗しました: ${e.toString()}')),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'メールアドレス',
                    hintText: 'example@example.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'メールアドレスを入力してください';
                    }
                    if (!EmailValidator.validate(value)) {
                      return '有効なメールアドレスを入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パスワードを入力してください';
                    }
                    if (value.length < 6) {
                      return 'パスワードは6文字以上である必要があります';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToForgotPassword,
                    child: const Text('パスワードをお忘れですか？'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _signInWithEmail,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('ログイン'),
                ),

                // ソーシャルログインを有効化
                const SizedBox(height: 16),
                const Text(
                  'または',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorTokens.textSecondary),
                ),
                const SizedBox(height: 16),
                SocialButton(
                  text: 'Googleでログイン',
                  icon: 'assets/icons/google.png',
                  onPressed: isLoading ? null : _signInWithGoogle,
                ),

                // Appleログインは一時的にコメントアウトしたままにする
                /*
                const SizedBox(height: 12),
                SocialButton(
                  text: 'Appleでログイン',
                  icon: 'assets/icons/apple.png',
                  onPressed: isLoading ? null : _signInWithApple,
                ),
                */

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('アカウントをお持ちでないですか？'),
                    TextButton(
                      onPressed: _navigateToSignUp,
                      child: const Text('新規登録'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
