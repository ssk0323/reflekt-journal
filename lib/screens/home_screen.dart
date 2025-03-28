import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';
import 'package:reflekt_app/models/diary_entry.dart';
import 'package:reflekt_app/models/insight.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _viewMode = 'calendar'; // calendar or list
  DateTime _currentMonth = DateTime.now();

  // モックデータ
  final List<DiaryEntry> entries = [
    DiaryEntry(
      id: '1',
      title: '春の散歩',
      content: '今日は公園で桜を見てきました。とても綺麗でした。',
      date: DateTime.now().subtract(Duration(days: 1)),
      emotion: 'happy',
      hasImage: true,
      imageUrl: 'https://source.unsplash.com/random/300x200/?sakura',
    ),
    DiaryEntry(
      id: '2',
      title: '仕事の進捗',
      content: 'プロジェクトが順調に進んでいます。',
      date: DateTime.now().subtract(Duration(days: 2)),
      emotion: 'neutral',
      hasImage: false,
    ),
    DiaryEntry(
      id: '3',
      title: '友人との会話',
      content: '久しぶりに会った友人と良い時間を過ごしました。',
      date: DateTime.now().subtract(Duration(days: 3)),
      emotion: 'happy',
      hasImage: true,
      imageUrl: 'https://source.unsplash.com/random/300x200/?friends',
    ),
  ];

  final List<Insight> insights = [
    Insight(
      id: '1',
      title: '最近の傾向',
      content: 'ここ2週間、ポジティブな気持ちが増加しています。この調子を維持しましょう！',
    ),
    Insight(
      id: '2',
      title: '改善提案',
      content: '朝の散歩があなたの気分を良くしているようです。毎日15分の散歩を習慣にしてみませんか？',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildViewToggle(),
          SizedBox(height: 16),
          _viewMode == 'calendar' ? _buildCalendarView() : _buildListView(),
          SizedBox(height: 24),
          _buildInsights(),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildToggleButton('カレンダー', 'calendar'),
            SizedBox(width: 8),
            _buildToggleButton('リスト', 'list'),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left, size: 20),
              onPressed: () => _changeMonth(-1),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            Text(
              DateFormat('yyyy年M月').format(_currentMonth),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, size: 20),
              onPressed: () => _changeMonth(1),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String label, String mode) {
    final isSelected = _viewMode == mode;
    return InkWell(
      onTap: () => setState(() => _viewMode = mode),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    // カレンダーの曜日見出し
    final weekDays = ['日', '月', '火', '水', '木', '金', '土'];

    // 現在の月の初日
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);

    // 現在の月の最終日
    final lastDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    // カレンダー開始日（その月の最初の週の日曜日）
    final firstDayOfCalendar =
        firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));

    // カレンダー終了日（その月の最後の週の土曜日）
    final lastDayOfCalendar =
        lastDayOfMonth.add(Duration(days: (6 - lastDayOfMonth.weekday) % 7));

    // カレンダーに表示する日付のリスト
    final daysInCalendar = List.generate(
      lastDayOfCalendar.difference(firstDayOfCalendar).inDays + 1,
      (index) => firstDayOfCalendar.add(Duration(days: index)),
    );

    return Column(
      children: [
        // 曜日見出し行
        Row(
          children: weekDays
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 8),
        // カレンダーグリッド
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: daysInCalendar.map((date) {
            bool isCurrentMonth = date.month == _currentMonth.month;
            bool hasEntry = entries.any((entry) =>
                DateFormat('yyyy-MM-dd').format(entry.date) ==
                DateFormat('yyyy-MM-dd').format(date));

            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
                color: isCurrentMonth ? Colors.white : AppColors.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isCurrentMonth
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (hasEntry)
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return Column(
      children: entries
          .map((entry) => Card(
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('yyyy/MM/dd').format(entry.date),
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textSecondary),
                          ),
                          _buildEmotionIcon(entry.emotion),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        entry.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4),
                      Text(
                        entry.content,
                        style: TextStyle(
                            fontSize: 14, color: AppColors.textPrimary),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (entry.hasImage && entry.imageUrl != null) ...[
                        SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            entry.imageUrl!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI洞察',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        ...insights
            .map((insight) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insight.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        insight.content,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildEmotionIcon(String emotion) {
    IconData icon;
    Color color;

    switch (emotion) {
      case 'happy':
        icon = Icons.sentiment_very_satisfied;
        color = AppColors.happy;
        break;
      case 'sad':
        icon = Icons.sentiment_dissatisfied;
        color = AppColors.sad;
        break;
      case 'angry':
        icon = Icons.sentiment_very_dissatisfied;
        color = AppColors.angry;
        break;
      case 'neutral':
      default:
        icon = Icons.sentiment_neutral;
        color = AppColors.neutral;
    }

    return Icon(icon, color: color, size: 16);
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + offset,
        1,
      );
    });
  }
}
