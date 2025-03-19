# Reflekt App

Reflekt は自己反省と成長をサポートするモバイルアプリケーションです。日々の振り返りを記録し、パターンを分析して自己成長を促進します。

## 技術スタック

- **フロントエンド**: Flutter
- **バックエンド**: Firebase
  - Authentication: ユーザー認証
  - Firestore: データベース
  - Cloud Functions: サーバーレス関数
  - Cloud Storage: 画像やファイルの保存

## 主な機能

- ユーザー認証（メールアドレス、Google、Apple アカウント）
- 日々の振り返りジャーナルの記録
- 気分や感情のトラッキング
- 写真や画像の添付
- カスタマイズ可能なリマインダー
- レポートと分析による自己成長の可視化
- ダークモード対応 UI

## インストール手順

### 開発環境のセットアップ

1. **Flutter SDK のインストール**:
   [Flutter 公式サイト](https://flutter.dev/docs/get-started/install)から SDK をダウンロードしてインストールしてください。
2. **依存関係のインストール**:

   ```bash
   flutter pub get
   ```

3. **Firebase プロジェクトのセットアップ**:

   - [Firebase Console](https://console.firebase.google.com/)で新しいプロジェクトを作成
   - Flutter アプリを Firebase プロジェクトに追加
   - `google-services.json` (Android 用) と `GoogleService-Info.plist` (iOS 用) をダウンロードし、適切なディレクトリに配置

4. **アプリケーションの実行**:

   ```bash
   flutter run
   ```

## 開発ガイドライン

- コードは Dart/Flutter 標準に従ってフォーマットしてください
- 新機能の追加にはテストを含めてください
- コミットメッセージは明確で詳細に記述してください

## 開発予定の機能

- コミュニティ機能 - 同じ目標を持つユーザー同士の繋がり
- AI による洞察と成長提案
- 目標設定と進捗管理機能
- カスタマイズ可能なテーマと UI
- オフライン対応と同期機能

## 貢献方法

1. リポジトリをフォーク
2. 新しいブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. Pull Request を作成

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。
