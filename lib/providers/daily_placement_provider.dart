import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/models/daily_record.dart';
import 'package:yoichiyatai/services/placement_calculator.dart';
import 'package:yoichiyatai/services/analytics_service.dart';
import 'package:yoichiyatai/utils/date_helper.dart';
import 'app_user_provider.dart';
import 'user_provider.dart';

class DailyPlacementState {
  final Map<int, String> layout;
  final int previousRevenue;
  final bool isConfirmed;
  final bool isConfirming;

  DailyPlacementState({
    required this.layout,
    this.previousRevenue = 0,
    this.isConfirmed = false,
    this.isConfirming = false,
  });

  DailyPlacementState copyWith({
    Map<int, String>? layout,
    int? previousRevenue,
    bool? isConfirmed,
    bool? isConfirming,
  }) {
    return DailyPlacementState(
      layout: layout ?? this.layout,
      previousRevenue: previousRevenue ?? this.previousRevenue,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isConfirming: isConfirming ?? this.isConfirming,
    );
  }

  int get currentRevenue =>
      PlacementCalculator.calculateRevenue(layout, Stall.defaultStalls);

  bool get isLayoutFull => layout.values.where((v) => v.isEmpty).isEmpty;

  bool get isAhaMoment =>
      isConfirmed && previousRevenue > 0 && currentRevenue > previousRevenue;
}

class DailyPlacementNotifier extends StateNotifier<DailyPlacementState> {
  final Ref _ref;

  DailyPlacementNotifier(this._ref)
      : super(DailyPlacementState(layout: DailyRecord.emptyLayout()));

  // Aha Moment（「昨日より改善できた」）判定のため、前日の確定売上を
  // Firestoreから読み込んでセットする。HomeScreen表示時に一度呼び出す想定。
  Future<void> loadPreviousRevenue() async {
    try {
      final user = await _ref.read(currentUserProvider.future);
      if (user == null) return;

      final firestoreService = _ref.read(firestoreServiceProvider);
      final yesterdayData = await firestoreService.getDailyRecord(
        user.uid,
        DateHelper.yesterdayString(),
      );

      if (yesterdayData != null) {
        final yesterdayRecord = DailyRecord.fromFirestore(yesterdayData);
        setPreviousRevenue(yesterdayRecord.revenue);
      }
    } catch (_) {
      // 前日データが取得できなくてもAha Moment判定がfalseになるだけなので握りつぶす
    }
  }

  void updateCell(int position, String stallId) {
    if (state.isConfirmed) return; // 確定後は変更不可
    final newLayout = Map<int, String>.from(state.layout);
    newLayout[position] = stallId;
    state = state.copyWith(layout: newLayout);
  }

  void clearCell(int position) {
    if (state.isConfirmed) return;
    updateCell(position, '');
  }

  void resetLayout() {
    state = DailyPlacementState(
      layout: DailyRecord.emptyLayout(),
      previousRevenue: state.currentRevenue,
    );
  }

  Future<void> confirmPlacement() async {
    if (state.isConfirming || state.isConfirmed) return; // ダブルタップ保護
    state = state.copyWith(isConfirming: true);

    final revenue = state.currentRevenue;
    final wasAhaMoment = state.previousRevenue > 0 && revenue > state.previousRevenue;

    try {
      final user = await _ref.read(currentUserProvider.future);
      if (user != null) {
        final firestoreService = _ref.read(firestoreServiceProvider);
        final today = DateHelper.todayString();

        await firestoreService.saveDailyRecord(
          user.uid,
          today,
          DailyRecord(
            date: today,
            layout: state.layout,
            revenue: revenue,
            missionComplete: true,
            createdAt: DateTime.now(),
          ).toFirestore(),
        );

        final actions = _ref.read(appUserActionsProvider);
        await actions?.updateAfterPlacement(revenue: revenue, isNewDay: true);

        final analytics = AnalyticsService();
        await analytics.logDailyPlacementConfirmed(
          revenue: revenue,
          level: 0,
          streak: 0,
          sessionDurationSeconds: 0,
        );
        if (wasAhaMoment) {
          final improvementPercent =
              ((revenue - state.previousRevenue) / state.previousRevenue * 100).round();
          await analytics.logAhaMomentReached(
            previousRevenue: state.previousRevenue,
            currentRevenue: revenue,
            improvementPercent: improvementPercent,
          );
        }
      }
    } catch (_) {
      // オフライン等での保存失敗はローカル状態を維持しつつ握りつぶす（Phase以降でリトライキュー化）
    }

    state = state.copyWith(isConfirmed: true, isConfirming: false);
  }

  void setPreviousRevenue(int revenue) {
    state = state.copyWith(previousRevenue: revenue);
  }
}

final dailyPlacementProvider =
    StateNotifierProvider<DailyPlacementNotifier, DailyPlacementState>(
  (ref) => DailyPlacementNotifier(ref),
);

// 現在のレイアウトでの売上（リアルタイム計算）
final currentRevenueProvider = Provider<int>((ref) {
  final state = ref.watch(dailyPlacementProvider);
  return state.currentRevenue;
});

// Aha Moment 判定（前回より改善したか）
final ahaMomentProvider = Provider<bool>((ref) {
  final state = ref.watch(dailyPlacementProvider);
  return state.isAhaMoment;
});
