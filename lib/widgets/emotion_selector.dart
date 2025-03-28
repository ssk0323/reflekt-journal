import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

enum Emotion {
  happy,
  neutral,
  sad,
  angry,
}

class EmotionSelector extends StatelessWidget {
  final Emotion? selectedEmotion;
  final Function(Emotion) onEmotionSelected;

  const EmotionSelector({
    Key? key,
    this.selectedEmotion,
    required this.onEmotionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildEmotionButton(
          context,
          emotion: Emotion.happy,
          icon: Icons.sentiment_very_satisfied,
          color: AppColors.happy,
          label: '嬉しい',
        ),
        _buildEmotionButton(
          context,
          emotion: Emotion.neutral,
          icon: Icons.sentiment_neutral,
          color: AppColors.neutral,
          label: '普通',
        ),
        _buildEmotionButton(
          context,
          emotion: Emotion.sad,
          icon: Icons.sentiment_dissatisfied,
          color: AppColors.sad,
          label: '悲しい',
        ),
        _buildEmotionButton(
          context,
          emotion: Emotion.angry,
          icon: Icons.sentiment_very_dissatisfied,
          color: AppColors.angry,
          label: '怒り',
        ),
      ],
    );
  }

  Widget _buildEmotionButton(
    BuildContext context, {
    required Emotion emotion,
    required IconData icon,
    required Color color,
    required String label,
  }) {
    final bool isSelected = selectedEmotion == emotion;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: InkWell(
          onTap: () => onEmotionSelected(emotion),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? color : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? color : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
