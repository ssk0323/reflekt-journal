import 'package:flutter/material.dart';
import 'package:reflekt_app/design_system/theme/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _reminderEnabled = true;
  TimeOfDay _reminderTime = TimeOfDay(hour: 21, minute: 0);
  bool _weeklyReportEnabled = true;
  bool _featureNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知設定'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNotificationToggle(
              title: '日記リマインダー',
              subtitle: '毎日の日記記録を通知でお知らせします',
              value: _reminderEnabled,
              onChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                });
              },
            ),
            if (_reminderEnabled)
              _buildTimeSelector(
                title: 'リマインダー時刻',
                time: _reminderTime,
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: _reminderTime,
                  );
                  if (time != null) {
                    setState(() {
                      _reminderTime = time;
                    });
                  }
                },
              ),
            _buildNotificationToggle(
              title: '週間分析レポート',
              subtitle: '週ごとの感情分析レポートを通知します',
              value: _weeklyReportEnabled,
              onChanged: (value) {
                setState(() {
                  _weeklyReportEnabled = value;
                });
              },
            ),
            _buildNotificationToggle(
              title: '新機能のお知らせ',
              subtitle: '新しい機能や改善点についての通知',
              value: _featureNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _featureNotificationsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildTimeSelector({
    required String title,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(Icons.access_time, color: AppColors.textSecondary),
        title: Text(title),
        trailing: TextButton(
          onPressed: onTap,
          child: Text(
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
