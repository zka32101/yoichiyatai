# 🌙 夜市の屋台街 / Night Market Tycoon

毎日3×3マスに屋台を配置して、隣接シナジーで売上を最大化するパズル経営ゲーム

## 概要

- **コンセプト**: 日次リセット × 配置パズル × 街成長
- **Aha Moment**: 「昨日¥5,000の配置を、今日¥7,000に改善できた」という成功体験
- **ターゲット**: 25〜45歳、パズル好きな層
- **セッション時間**: 30秒（配置決定 + 確認）
- **マネタイズ**: 月¥300サブスク（発展スピード2倍）

## 技術スタック

```
Dart 3.x / Flutter 3.x
状態管理: Riverpod
DB: Firebase Firestore + Drift（ローカル）
認証: Firebase Auth（匿名＋Google）
課金: RevenueCat
アニメーション: Lottie + Flutter Animate
計測: Firebase Analytics / Crashlytics / Remote Config
```

## セットアップ

### 1. 依存パッケージインストール

```bash
cd yoichiyatai
flutter pub get
```

### 2. 環境設定

`.env.local` ファイルを作成（`.env.local.example` を参照）:

```
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID_ANDROID=your_android_app_id
FIREBASE_APP_ID_IOS=your_ios_app_id
REVENUCAT_API_KEY=your_revenucat_api_key
```

### 3. 開発実行

```bash
flutter run
```

## プロジェクト構造

```
lib/
├── main.dart              # エントリーポイント
├── config/                # Firebase / RevenueCat設定
├── models/                # データモデル
├── services/              # ビジネスロジック
├── providers/             # Riverpod状態管理
├── screens/               # 画面（スプラッシュ、ホーム、結果など）
├── widgets/               # 再利用可能ウィジェット
├── utils/                 # ヘルパー関数
└── theme/                 # テーマ・カラー・フォント
```

## 実装スケジュール（8週間MVP）

### Phase 1: 基盤整備（Week 1-2）
- [ ] Firebase接続
- [ ] Riverpod セットアップ
- [ ] テーマ定義

### Phase 2: データ層（Week 2-3）
- [ ] モデル定義
- [ ] Firestore Security Rules
- [ ] Drift ローカルDB
- [ ] placement_calculator エンジン

### Phase 3: Service層（Week 3-4）
- [ ] FirestoreService
- [ ] AuthService
- [ ] RevenueService
- [ ] AnalyticsService

### Phase 4: UI基本（Week 4-5）
- [ ] SplashScreen
- [ ] TutorialScreen
- [ ] **GridCell / HomeScreen**（最優先・Aha Moment動線）
- [ ] StallSelector

### Phase 5: ホーム機能（Week 5-6）
- [ ] 配置確定ロジック
- [ ] ResultScreen
- [ ] ストリーク表示

### Phase 6: 拡張機能（Week 6-7）
- [ ] LeaderboardScreen
- [ ] ShopScreen（課金）
- [ ] アニメーション実装

### Phase 7: テスト＆ポーランド（Week 7-8）
- [ ] Unit / Widget test
- [ ] Integration test
- [ ] CI/CD設定

## OKR（3ヶ月）

```
KR1: Day7 リテンション 30%+
KR2: Day30 リテンション 12%+
KR3: 平均セッション 3分/日
KR4: 街レベル5到達率 60%+
```

## 注意点

- **最優先**: Aha Moment への最短動線（Grid配置 → 売上計算 → 改善実感）
- **セキュリティ**: APIキーは `.env.local` で管理
- **課金事故防止**: Integration test + sandbox検証 + ダブルタップ保護
- **パフォーマンス**: Grid描画 60fps（CustomPaint）、API タイムアウト 10秒・リトライ3回

## 参考資料

- 企画書: `G:\マイドライブ\design\yoichiyatai\yoichi-yatai-plan_v1_0.md`
- 設計書: `G:\マイドライブ\design\yoichiyatai\yoichi-yatai-design_v1_0.md`
- 実装ガイド: `G:\マイドライブ\design\yoichiyatai\yoichi-yatai-code-handoff_v1_0.md`
- CLAUDE.md: このプロジェクトの実装ガイド

## ライセンス

Private Project
