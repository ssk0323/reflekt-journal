import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';
import 'package:reflekt_app/widgets/emotion_selector.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({Key? key}) : super(key: key);

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _questionResponseController = TextEditingController();

  Emotion? _selectedEmotion;
  File? _selectedImage;
  bool _isLoading = false;

  // モック質問
  final List<String> questions = [
    '今日、最も感謝していることは何ですか？',
    '今日の小さな成功は何でしたか？',
    '明日に向けてどんな期待がありますか？',
  ];

  int _currentQuestionIndex = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _questionResponseController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _saveEntry() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('タイトルを入力してください')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 実際のアプリでは、ここでFirebaseにデータを保存
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleField(),
                    SizedBox(height: 16),
                    _buildContentField(),
                    SizedBox(height: 24),
                    _buildDailyQuestion(),
                    SizedBox(height: 24),
                    _buildEmotionSection(),
                    SizedBox(height: 24),
                    _buildImageSection(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.close),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 16),
              Text(
                '新しい記録',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: _saveEntry,
            icon: Icon(Icons.save, size: 16),
            label: Text('保存'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: 'タイトル',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8),
      ),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildContentField() {
    return TextFormField(
      controller: _contentController,
      decoration: InputDecoration(
        hintText: '今日はどんな一日でしたか？',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: EdgeInsets.all(12),
      ),
      maxLines: 6,
    );
  }

  Widget _buildDailyQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '今日の質問:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questions[_currentQuestionIndex],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _questionResponseController,
                decoration: InputDecoration(
                  hintText: '回答を入力...',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '今日の気分:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        EmotionSelector(
          selectedEmotion: _selectedEmotion,
          onEmotionSelected: (emotion) {
            setState(() {
              _selectedEmotion = emotion;
            });
          },
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '画像の追加:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _pickImage,
              color: AppColors.textSecondary,
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _selectedImage == null
                  ? Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[400],
                      size: 32,
                    )
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
