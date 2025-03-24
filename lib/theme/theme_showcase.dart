import 'package:flutter/material.dart';
import '../design_system/components/index.dart';
import '../design_system/tokens/index.dart';

class ThemeShowcase extends StatelessWidget {
  const ThemeShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'デザインシステム',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypographySection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildColorsSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildButtonsSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildTextFieldsSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildCardsSection(context),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildTagsSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildSwitchesSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildIconButtonsSection(),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildDialogsSection(context),
            SizedBox(height: SizeTokens.spacingLg),
            AppDivider(),
            SizedBox(height: SizeTokens.spacingLg),
            _buildLoadingSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('タイポグラフィ'),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.displayLarge('見出し大 (H1)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.displayMedium('見出し中 (H2)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.heading('見出し小 (H3)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.subheading('小見出し (Subheading)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.title('タイトル (Title)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.body('本文テキスト (Body)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.small('小さいテキスト (Small)'),
        SizedBox(height: SizeTokens.spacingSm),
        AppText.caption('キャプション (Caption)'),
      ],
    );
  }

  Widget _buildColorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('カラー'),
        SizedBox(height: SizeTokens.spacingMd),

        // プライマリカラー
        _buildColorItem('プライマリ', ColorTokens.primary),
        _buildColorItem('プライマリ (薄)', ColorTokens.primaryLight),

        SizedBox(height: SizeTokens.spacingMd),
        // テキストカラー
        _buildColorItem('テキスト（濃）', ColorTokens.textPrimary),
        _buildColorItem('テキスト（薄）', ColorTokens.textSecondary),

        SizedBox(height: SizeTokens.spacingMd),
        // 背景色
        _buildColorItem('背景（メイン）', ColorTokens.backgroundPrimary),
        _buildColorItem('背景（セカンダリ）', ColorTokens.backgroundSecondary),

        SizedBox(height: SizeTokens.spacingMd),
        // アクセントカラー
        _buildColorItem('アクセント（青）', ColorTokens.accentBlue),
        _buildColorItem('アクセント（黄）', ColorTokens.accentYellow),
        _buildColorItem('アクセント（緑）', ColorTokens.accentGreen),
        _buildColorItem('アクセント（紫）', ColorTokens.accentPurple),

        SizedBox(height: SizeTokens.spacingMd),
        // UI要素
        _buildColorItem('ボーダー', ColorTokens.border),
        _buildColorItem('エラー', ColorTokens.error),
      ],
    );
  }

  Widget _buildColorItem(String name, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeTokens.spacingSm),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(SizeTokens.radiusSm),
              border: color == ColorTokens.backgroundPrimary
                  ? Border.all(color: ColorTokens.border)
                  : null,
            ),
          ),
          SizedBox(width: SizeTokens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subheading(name),
                AppText.small(
                  '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
                  color: ColorTokens.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('ボタン'),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('ボタンタイプ'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppButton(
              text: 'プライマリ',
              onPressed: () {},
            ),
            AppButton(
              text: 'セカンダリ',
              type: AppButtonType.secondary,
              onPressed: () {},
            ),
            AppButton(
              text: 'テキスト',
              type: AppButtonType.text,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('ボタンサイズ'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppButton(
              text: '小',
              size: AppButtonSize.small,
              onPressed: () {},
            ),
            AppButton(
              text: '中',
              size: AppButtonSize.medium,
              onPressed: () {},
            ),
            AppButton(
              text: '大',
              size: AppButtonSize.large,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('アイコン付きボタン'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppButton(
              text: '前アイコン',
              leadingIcon: Icons.add,
              onPressed: () {},
            ),
            AppButton(
              text: '後ろアイコン',
              trailingIcon: Icons.arrow_forward,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('幅いっぱいボタン'),
        SizedBox(height: SizeTokens.spacingSm),
        AppButton(
          text: '幅いっぱい',
          isFullWidth: true,
          onPressed: () {},
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('ローディングボタン'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppButton(
              text: 'ローディング',
              isLoading: true,
              onPressed: () {},
            ),
            AppButton(
              text: 'ローディング',
              type: AppButtonType.secondary,
              isLoading: true,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('角型ボタン'),
        SizedBox(height: SizeTokens.spacingSm),
        AppButton(
          text: '角型ボタン',
          borderRadius: SizeTokens.radiusMd,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTextFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('テキストフィールド'),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: '標準入力',
          hint: 'ヒントテキスト',
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: 'ラベル付き',
          hint: 'ヒントテキスト',
          helperText: 'ヘルパーテキスト',
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: 'エラー状態',
          hint: 'ヒントテキスト',
          errorText: 'エラーメッセージ',
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: '無効状態',
          hint: 'ヒントテキスト',
          enabled: false,
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: 'パスワード',
          hint: 'パスワードを入力',
          obscureText: true,
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: '複数行',
          hint: '複数行のテキスト',
          maxLines: 3,
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppTextField(
          label: 'アイコン付き',
          hint: '検索',
          prefix: Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildCardsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('カード'),
        SizedBox(height: SizeTokens.spacingMd),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('標準カード'),
              SizedBox(height: SizeTokens.spacingSm),
              AppText.body('これは標準的なカードコンポーネントです。'),
            ],
          ),
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppCard(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('影付きカード'),
              SizedBox(height: SizeTokens.spacingSm),
              AppText.body('影の高さを調整したカードです。'),
            ],
          ),
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppCard(
          hasBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('枠線付きカード'),
              SizedBox(height: SizeTokens.spacingSm),
              AppText.body('枠線を表示したカードです。'),
            ],
          ),
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppCard(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('カードがタップされました')),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.heading('タップ可能なカード'),
              SizedBox(height: SizeTokens.spacingSm),
              AppText.body('このカードはタップすることができます。'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('タグ'),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('タグタイプ'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppTag(text: 'プライマリ'),
            AppTag(text: '青', type: TagType.blue),
            AppTag(text: '黄', type: TagType.yellow),
            AppTag(text: '緑', type: TagType.green),
            AppTag(text: '紫', type: TagType.purple),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('選択状態'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppTag(text: 'プライマリ', isSelected: true),
            AppTag(text: '青', type: TagType.blue, isSelected: true),
            AppTag(text: '黄', type: TagType.yellow, isSelected: true),
            AppTag(text: '緑', type: TagType.green, isSelected: true),
            AppTag(text: '紫', type: TagType.purple, isSelected: true),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppText.heading('アイコン付きタグ'),
        SizedBox(height: SizeTokens.spacingSm),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppTag(text: '天気', icon: Icons.wb_sunny, type: TagType.yellow),
            AppTag(text: '場所', icon: Icons.place, type: TagType.primary),
            AppTag(text: '人物', icon: Icons.person, type: TagType.blue),
            AppTag(text: '気分', icon: Icons.mood, type: TagType.green),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchesSection() {
    return StatefulBuilder(builder: (context, setState) {
      bool switchValue1 = true;
      bool switchValue2 = false;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.displayLarge('スイッチ'),
          SizedBox(height: SizeTokens.spacingMd),
          Row(
            children: [
              AppSwitch(
                value: switchValue1,
                onChanged: (value) {
                  setState(() {
                    switchValue1 = value;
                  });
                },
              ),
              SizedBox(width: SizeTokens.spacingMd),
              AppText.body('オン状態'),
            ],
          ),
          SizedBox(height: SizeTokens.spacingMd),
          Row(
            children: [
              AppSwitch(
                value: switchValue2,
                onChanged: (value) {
                  setState(() {
                    switchValue2 = value;
                  });
                },
              ),
              SizedBox(width: SizeTokens.spacingMd),
              AppText.body('オフ状態'),
            ],
          ),
          SizedBox(height: SizeTokens.spacingMd),
          AppSwitch(
            value: true,
            onChanged: null,
            disabled: true,
            label: '無効状態 (オン)',
          ),
          SizedBox(height: SizeTokens.spacingMd),
          AppSwitch(
            value: false,
            onChanged: null,
            disabled: true,
            label: '無効状態 (オフ)',
          ),
        ],
      );
    });
  }

  Widget _buildIconButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('アイコンボタン'),
        SizedBox(height: SizeTokens.spacingMd),
        Wrap(
          spacing: SizeTokens.spacingMd,
          runSpacing: SizeTokens.spacingMd,
          children: [
            AppIconButton(
              icon: Icons.favorite,
              onPressed: () {},
              tooltip: 'お気に入り',
            ),
            AppIconButton(
              icon: Icons.share,
              onPressed: () {},
              backgroundColor: Color(0xFFF5F5F5),
              tooltip: '共有',
            ),
            AppIconButton(
              icon: Icons.delete,
              onPressed: () {},
              color: ColorTokens.error,
              tooltip: '削除',
            ),
            AppIconButton(
              icon: Icons.edit,
              onPressed: () {},
              hasBorder: true,
              tooltip: '編集',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDialogsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('ダイアログ'),
        SizedBox(height: SizeTokens.spacingMd),
        Wrap(
          spacing: SizeTokens.spacingSm,
          runSpacing: SizeTokens.spacingSm,
          children: [
            AppButton(
              text: '確認ダイアログ',
              onPressed: () {
                AppDialog.show(
                  context: context,
                  title: '確認',
                  content: '本当にこの操作を実行しますか？',
                  positiveButtonText: '実行',
                  negativeButtonText: 'キャンセル',
                );
              },
            ),
            AppButton(
              text: 'アイコン付きダイアログ',
              onPressed: () {
                AppDialog.show(
                  context: context,
                  title: '成功',
                  content: '操作が正常に完了しました。',
                  positiveButtonText: 'OK',
                  icon: Icon(
                    Icons.check_circle,
                    color: ColorTokens.accentGreen,
                    size: 48,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.displayLarge('ローディング'),
        SizedBox(height: SizeTokens.spacingMd),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                AppLoading(size: 24),
                SizedBox(height: SizeTokens.spacingSm),
                AppText.body('小'),
              ],
            ),
            Column(
              children: [
                AppLoading(),
                SizedBox(height: SizeTokens.spacingSm),
                AppText.body('中'),
              ],
            ),
            Column(
              children: [
                AppLoading(size: 56),
                SizedBox(height: SizeTokens.spacingSm),
                AppText.body('大'),
              ],
            ),
          ],
        ),
        SizedBox(height: SizeTokens.spacingMd),
        AppButton(
          text: 'オーバーレイローディング表示',
          onPressed: () {
            final entry = AppLoading.showOverlay(
              context,
              message: '読み込み中...',
            );

            Future.delayed(Duration(seconds: 2), () {
              entry.remove();
            });
          },
        ),
      ],
    );
  }
}
