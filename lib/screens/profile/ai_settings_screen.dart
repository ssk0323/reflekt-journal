import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

class AISettingsScreen extends StatefulWidget {
  const AISettingsScreen({Key? key}) : super(key: key);

  @override
  _AISettingsScreenState createState() => _AISettingsScreenState();
}

class _AISettingsScreenState extends State<AISettingsScreen> {
  bool _aiAnalysisEnabled = true;
  double _questionDifficulty = 3.0;

  final Map<String, bool> _analysisCategories = {
    'emotion': true,
    'keywords': true,
    'patterns': true,
    'suggestions': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI解析設定'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleContainer(
              title: 'AI解析を有効にする',
              subtitle: '日記の内容をAIが分析し洞察を提供します',
              value: _aiAnalysisEnabled,
              onChanged: (value) {
                setState(() {
                  _aiAnalysisEnabled = value;
                });
              },
            ),
            if (_aiAnalysisEnabled) ...[
              SizedBox(height: 16),
              _buildCategoriesSection(),
              SizedBox(height: 16),
              _buildDifficultySection(),
              SizedBox(height: 16),
              _buildPrivacySection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToggleContainer({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '分析対象カテゴリ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          _buildCategoryCheckbox('emotion', '感情分析'),
          SizedBox(height: 8),
          _buildCategoryCheckbox('keywords', 'キーワード抽出'),
          SizedBox(height: 8),
          _buildCategoryCheckbox('patterns', '行動パターン分析'),
          SizedBox(height: 8),
          _buildCategoryCheckbox('suggestions', '改善提案'),
        ],
      ),
    );
  }

  Widget _buildCategoryCheckbox(String id, String label) {
    return Row(
      children: [
        Checkbox(
          value: _analysisCategories[id],
          onChanged: (value) {
            setState(() {
              _analysisCategories[id] = value!;
            });
          },
          activeColor: AppColors.primary,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildDifficultySection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '質問の難易度',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'AIが提供する日記質問の深さを調整します',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'シンプル',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Expanded(
                child: Slider(
                  value: _questionDifficulty,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _questionDifficulty.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _questionDifficulty = value;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
              ),
              Text(
                '深い',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'データプライバシー',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'AIは日記データをデバイス上で解析します。データはあなたのデバイスから送信されることはありません。',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          TextButton(
            onPressed: () {
              // プライバシーポリシーを表示する処理
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'プライバシーポリシーを表示',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
