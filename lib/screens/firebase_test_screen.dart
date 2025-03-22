import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reflekt_app/services/firebase/auth_service.dart';
import 'package:reflekt_app/services/firebase/firestore_service.dart';
import 'package:reflekt_app/services/firebase/storage_service.dart';

class FirebaseTestScreen extends StatefulWidget {
  const FirebaseTestScreen({super.key});

  @override
  State<FirebaseTestScreen> createState() => _FirebaseTestScreenState();
}

class _FirebaseTestScreenState extends State<FirebaseTestScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final ImagePicker _picker = ImagePicker();

  String? _userId;
  String? _entryId;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase機能テスト'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 認証セクション
            _buildSection(
              title: '認証テスト',
              children: [
                ElevatedButton(
                  onPressed: _testAnonymousAuth,
                  child: const Text('匿名ログイン'),
                ),
                const SizedBox(height: 8),
                Text('ユーザーID: ${_userId ?? "未ログイン"}'),
              ],
            ),

            // Firestoreセクション
            _buildSection(
              title: 'Firestoreテスト',
              children: [
                ElevatedButton(
                  onPressed: _userId != null ? _testCreateDiaryEntry : null,
                  child: const Text('日記エントリー作成'),
                ),
                const SizedBox(height: 8),
                Text('エントリーID: ${_entryId ?? "未作成"}'),
              ],
            ),

            // Storageセクション
            _buildSection(
              title: 'Storageテスト',
              children: [
                ElevatedButton(
                  onPressed: _userId != null ? _testUploadImage : null,
                  child: const Text('画像アップロード'),
                ),
                const SizedBox(height: 8),
                _imageUrl != null
                    ? Column(
                        children: [
                          Image.network(
                            _imageUrl!,
                            height: 150,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed:
                                _imageUrl != null ? _testDeleteImage : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('画像削除'),
                          ),
                        ],
                      )
                    : const Text('画像未アップロード'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }

  // 匿名ログインのテスト
  Future<void> _testAnonymousAuth() async {
    try {
      final user = await _authService.signInAnonymously();
      setState(() {
        _userId = user?.uid;
      });
      _showMessage('匿名ログイン成功: ${user?.uid}');
    } catch (e) {
      _showError('匿名ログイン失敗: $e');
    }
  }

  // 日記エントリー作成のテスト
  Future<void> _testCreateDiaryEntry() async {
    try {
      if (_userId == null) {
        _showMessage('先にログインしてください');
        return;
      }

      final data = {
        'title': 'テストエントリー',
        'content': 'これはFirestoreのテストです。${DateTime.now()}',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      final docRef = await _firestoreService.createDiaryEntry(_userId!, data);
      setState(() {
        _entryId = docRef.id;
      });
      _showMessage('エントリー作成成功: ${docRef.id}');
    } catch (e) {
      _showError('エントリー作成失敗: $e');
    }
  }

  // 画像アップロードのテスト
  Future<void> _testUploadImage() async {
    try {
      if (_userId == null) {
        _showMessage('先にログインしてください');
        return;
      }

      // 画像の選択
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        _showMessage('画像が選択されませんでした');
        return;
      }

      // 選択した画像をそのままアップロード (File変換せずにXFileのままで渡す)
      final imageUrl = await _storageService.uploadImage(_userId!, pickedFile);
      setState(() {
        _imageUrl = imageUrl;
      });
      _showMessage('画像アップロード成功');
    } catch (e) {
      _showError('画像アップロード失敗: $e');
    }
  }

  // 画像削除のテスト
  Future<void> _testDeleteImage() async {
    try {
      if (_imageUrl == null) {
        _showMessage('削除する画像がありません');
        return;
      }

      await _storageService.deleteImage(_imageUrl!);
      setState(() {
        _imageUrl = null;
      });
      _showMessage('画像削除成功');
    } catch (e) {
      _showError('画像削除失敗: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
