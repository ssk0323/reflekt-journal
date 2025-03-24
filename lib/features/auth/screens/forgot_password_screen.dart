import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendPasswordResetEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ref.read(authNotifierProvider.notifier).sendPasswordResetEmail(
              _emailController.text.trim(),
            );
        setState(() {
          _isSent = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('パスワードリセットメールの送信に失敗しました: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('パスワードをリセット'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isSent
              ? _buildSuccessView(context)
              : _buildFormView(context, isLoading),
        ),
      ),
    );
  }

  Widget _buildFormView(BuildContext context, bool isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'パスワードをリセットするためのリンクを送信します',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: isLoading ? null : _sendPasswordResetEmail,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('リセットリンクを送信'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 80,
        ),
        const SizedBox(height: 24),
        Text(
          'パスワードリセットのメールを送信しました',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '${_emailController.text} 宛にパスワードをリセットするためのリンクを送信しました。メールをご確認ください。',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ログイン画面に戻る'),
        ),
      ],
    );
  }
}
