# 🌙 夜市の屋台街 / Night Market Tycoon

## Vision

毎日の配置パズルで「昨日より1%良い配置」を求める試行錯誤が、
結果として街を育てていく実感

## コアメカニクス

**3×3 Grid 配置パズル + 日次リセット + シナジーボーナス**

毎日朝、屋台を配置 → 隣接する屋台の相性でボーナス計算 → 売上表示 → 街レベルUP

### Aha Moment

「昨日¥5,000の配置を、今日¥7,000に改善できた」という成功体験

---

## 技術スタック

```
言語: Dart 3.x
UI: Flutter 3.x + Riverpod（状態管理）
DB: Firebase Firestore + Drift（ローカル）
認証: Firebase Auth（匿名＋Google）
課金: RevenueCat
アニメーション: Lottie + Flutter Animate
計測: Firebase Analytics / Crashlytics / Remote Config
```

---

## ディレクトリ構成

```
lib/
├── main.dart
├── config/
│  ├── firebase_config.dart
│  └── revenucat_config.dart
├── models/
│  ├── stall.dart（屋台タイプ）
│  ├── daily_record.dart（日記録）
│  ├── user.dart
│  └── synergy_table.dart
├── services/
│  ├── firestore_service.dart
│  ├── auth_service.dart
│  ├── revenucat_service.dart
│  ├── analytics_service.dart
│  └── placement_calculator.dart（売上計算エンジン）
├── providers/
│  ├── user_provider.dart
│  ├── daily_placement_provider.dart
│  ├── leaderboard_provider.dart
│  └── settings_provider.dart
├── screens/
│  ├── splash_screen.dart
│  ├── tutorial_screen.dart
│  ├── home_screen.dart（配置UI・最優先）
│  ├── result_screen.dart（前日結果）
│  ├── leaderboard_screen.dart
│  ├── shop_screen.dart（課金）
│  └── settings_screen.dart
├── widgets/
│  ├── grid_cell.dart
│  ├── stall_selector.dart
│  ├── revenue_display.dart
│  └── lottie_animation.dart
├── utils/
│  ├── analytics_helper.dart
│  └── date_helper.dart
└── theme/
   ├── colors.dart
   └── typography.dart
```

---

## 実装順序（推奨・8週間）

### Phase 1: 基盤整備（Week 1-2）
1. Firebase接続（Auth / Firestore / Analytics）
2. RevenueCat統合
3. Riverpod セットアップ
4. テーマ・カラー定義

### Phase 2: データ層（Week 2-3）
5. データモデル（Stall / DailyRecord / User）
6. Firestore Security Rules
7. Drift ローカルDB
8. **placement_calculator エンジン**（売上計算ロジック）

### Phase 3: Service層（Week 3-4）
9. FirestoreService
10. AuthService
11. RevenueService
12. AnalyticsService

### Phase 4: UI基本（Week 4-5）
13. SplashScreen
14. TutorialScreen
15. **GridCell + HomeScreen**（Aha Moment最短動線・最優先）
16. StallSelector

### Phase 5: ホーム画面（Week 5-6）
17. 配置確定ロジック
18. ResultScreen（前日結果 + ストリーク）

### Phase 6: 拡張機能（Week 6-7）
19. LeaderboardScreen
20. ShopScreen（課金）
21. アニメーション実装（Lottie 5種）
22. ハプティクスフィードバック

### Phase 7: テスト（Week 7-8）
23. Unit test（placement_calculator）
24. Widget test（GridCell / HomeScreen）
25. Integration test（課金フロー + Aha Moment動線）
26. CI/CD設定

---

## 実装のポイント

### ✅ 最優先

Aha Moment への最短動線：
- Grid配置 → 売上計算 → 改善実感

### ⚠️ 計測（Phase1から組込）

必須イベント：
```
aha_moment_reached      → 配置改善で売上UP時
daily_placement_confirmed → 毎日配置確定時
streak_{n}_reached      → 3日, 7日連続
paywall_viewed          → 課金画面表示
premium_purchased       → 課金完了
```

### 🎨 UI/UX

- Grid: CustomPaint で60fps（パフォーマンス重視）
- タップ領域: 最小45dp（44pt + マージン）
- アニメーション: Lottie JSON → `assets/animations/`
- ダークモード: 完全対応（#121212 背景）

### 🔐 セキュリティ

- APIキー: `.env.local` で管理（ハードコード禁止）
- Validation: サーバーサイドも必須
- 課金事故防止: Integration test + sandbox検証 + ダブルタップ保護

### 📊 パフォーマンス

- Firestore: インデックス事前作成
- API タイムアウト: 10秒・リトライ3回
- Grid描画: RepaintBoundary で最小化

---

## Firestore スキーマ

```
/users/{uid}
  ├─ createdAt: timestamp
  ├─ currentLevel: int
  ├─ totalRevenue: int
  ├─ unlockedStalls: [str]
  ├─ isPremium: bool
  ├─ lastPlayDate: date
  └─ streak: int

/dailyRecords/{uid}/{date}
  ├─ layout: Map<int, stall_id>
  ├─ revenue: int
  └─ missionComplete: bool

/stalls
  ├─ id: str
  ├─ name: str
  ├─ baseRevenue: int
  ├─ synergies: Map<stall_id, multiplier>
  └─ unlockedAtLevel: int

/leaderboard/{week}
  ├─ uid: str
  ├─ revenue: int
  └─ rank: int
```

---

## 開発コマンド

```bash
# 依存関係インストール
flutter pub get

# 開発実行
flutter run

# テスト実行
flutter test

# ビルド
flutter build apk
flutter build ios
```

---

## 参照資料

- `yoichi-yatai-plan_v1_0.md` — 企画書（ユーザー定義・機能リスト）
- `yoichi-yatai-design_v1_0.md` — 設計書（画面フロー・API仕様・計測）
- `yoichi-yatai-code-handoff_v1_0.md` — 実装引き継ぎ書

---

## OKR（3ヶ月）

```
KR1: Day7 リテンション 30%+
KR2: Day30 リテンション 12%+
KR3: 平均セッション 3分/日
KR4: 街レベル5到達率 60%+
```
