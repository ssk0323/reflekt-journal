import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // モックデータ
  final Map<String, double> emotionStats = {
    'happy': 65,
    'neutral': 20,
    'sad': 10,
    'angry': 5,
  };

  final List<String> keywords = [
    '散歩',
    '仕事',
    '友人',
    '家族',
    '読書',
    '食事',
    '睡眠',
    '運動'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '感情分析',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          _buildEmotionDistribution(),
          SizedBox(height: 24),
          _buildEmotionTrend(),
          SizedBox(height: 24),
          _buildKeywords(),
          SizedBox(height: 24),
          _buildAdvice(),
        ],
      ),
    );
  }

  Widget _buildEmotionDistribution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '今月の感情分布',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary),
        ),
        SizedBox(height: 8),
        // 積み上げバー
        Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              _buildEmotionBar('happy', AppColors.happy),
              _buildEmotionBar('neutral', AppColors.neutral),
              _buildEmotionBar('sad', AppColors.sad),
              _buildEmotionBar('angry', AppColors.angry),
            ],
          ),
        ),
        SizedBox(height: 8),
        // 凡例
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLegendItem('嬉しい', AppColors.happy, emotionStats['happy']!),
            _buildLegendItem('普通', AppColors.neutral, emotionStats['neutral']!),
            _buildLegendItem('悲しい', AppColors.sad, emotionStats['sad']!),
            _buildLegendItem('怒り', AppColors.angry, emotionStats['angry']!),
          ],
        ),
      ],
    );
  }

  Widget _buildEmotionBar(String emotion, Color color) {
    return Expanded(
      flex: emotionStats[emotion]!.round(),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: emotion == 'happy'
              ? BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )
              : emotion == 'angry'
                  ? BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )
                  : null,
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, double percentage) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          '$label (${percentage.toInt()}%)',
          style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildEmotionTrend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '気分の傾向 (過去3ヶ月)',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary),
        ),
        SizedBox(height: 8),
        Container(
          height: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(12, (index) {
              double height =
                  (50 + index * 2.5 + (index % 3) * 5).clamp(20, 90);
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${index + 1}週',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildKeywords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'よく使うキーワード',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keywords
              .map((keyword) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      keyword,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAdvice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '心理状態改善のためのアドバイス',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ストレス軽減のために',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '日記の内容から、仕事に関するストレスが見られます。毎日10分の瞑想を試してみてはいかがでしょうか？',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '瞑想ガイドを見る',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
