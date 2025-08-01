# KOFUKU - Clean Architecture Flutter App

KOFUKUは、クリーンアーキテクチャとMVVMパターンを採用したFlutterアプリケーションです。

## 🏗️ アーキテクチャ

このプロジェクトは以下のクリーンアーキテクチャ層で構成されています：

```
lib/
├── presentation/        # UI層 - Pages, Widgets, ViewModels
├── application/         # 状態管理・ユースケース層
├── domain/             # ドメイン層 - Entities, Repositories
├── infrastructure/     # データ層 - Repository実装, DataSources
├── game/              # ゲーム専用ロジック
└── utils/             # 共通ユーティリティ
```

## 🛠️ 技術スタック

- **フレームワーク**: Flutter
- **状態管理**: Riverpod
- **ルーティング**: Go Router
- **データ保存**: Hive
- **依存性注入**: Injectable + Get It
- **ネットワーク**: Dio + Retrofit
- **関数型プログラミング**: Dartz
- **UI**: Flutter ScreenUtil

## 📦 主要な依存関係

```yaml
dependencies:
  flutter_riverpod: ^2.5.1      # 状態管理
  go_router: ^14.6.2            # ルーティング
  hive: ^2.2.3                  # データ保存
  get_it: ^8.0.2                # 依存性注入
  injectable: ^2.5.0            # 依存性注入アノテーション
  dio: ^5.7.0                   # HTTP クライアント
  dartz: ^0.10.1                # 関数型プログラミング
  flutter_screenutil: ^5.9.3   # 画面サイズ対応
```

## 🚀 セットアップ

### 1. 依存関係のインストール
```bash
flutter pub get
```

### 2. コード生成の実行
```bash
dart run build_runner build
```

### 3. アプリの実行
```bash
flutter run
```

## 📱 機能

### 現在実装されている機能
- ✅ ホーム画面
- ✅ ユーザー一覧表示
- ✅ クリーンアーキテクチャの完全実装
- ✅ MVVMパターンによる状態管理
- ✅ 依存性注入の設定

### 今後追加予定の機能
- 🔄 ユーザーの追加・編集・削除
- 🔄 データの永続化
- 🔄 APIとの連携
- 🔄 エラーハンドリングの強化

## 🏗️ ディレクトリ構造の詳細

### Presentation層
- `pages/` - 画面コンポーネント
- `widgets/` - 再利用可能なUIコンポーネント
- `view_models/` - 状態管理とビジネスロジック
- `router/` - ルーティング設定

### Application層
- `usecases/` - ビジネスロジックの実行
- `providers/` - Riverpodプロバイダー
- `state/` - アプリケーション状態

### Domain層
- `entities/` - ビジネスエンティティ
- `repositories/` - リポジトリインターフェース
- `value_objects/` - 値オブジェクト

### Infrastructure層
- `repositories/` - リポジトリの具象実装
- `datasources/` - データソース（API、DB等）
- `models/` - データモデル

## 🔧 開発時のコマンド

### コード生成
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 監視モードでのコード生成
```bash
dart run build_runner watch
```

### 静的解析
```bash
flutter analyze
```

### テストの実行
```bash
flutter test
```

## 📝 コーディングガイドライン

1. **依存性の方向**: 外側の層から内側の層への依存のみ許可
2. **状態管理**: UIの状態はRiverpodで管理
3. **エラーハンドリング**: Either<Failure, Success>パターンを使用
4. **命名規則**: Dartの規約に従う
5. **コメント**: 複雑なビジネスロジックには適切なコメントを記載

## 🤝 コントリビューション

1. フィーチャーブランチを作成
2. 変更を実装
3. テストを追加
4. プルリクエストを作成

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。
