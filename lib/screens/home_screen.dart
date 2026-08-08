import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/providers/app_user_provider.dart';
import 'package:yoichiyatai/providers/daily_placement_provider.dart';
import 'package:yoichiyatai/utils/stall_display_helper.dart';
import 'package:yoichiyatai/widgets/grid_ui.dart';
import 'package:yoichiyatai/widgets/revenue_display.dart';
import 'package:yoichiyatai/widgets/stall_selector.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final int level;
  final int streak;
  final List<String> unlockedStalls;

  const HomeScreen({
    Key? key,
    this.level = 0,
    this.streak = 0,
    this.unlockedStalls = const ['yakiNiku', 'veggie', 'drink'],
  }) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Aha Moment判定用に前日の確定売上をFirestoreから読み込む
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dailyPlacementProvider.notifier).loadPreviousRevenue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final placementState = ref.watch(dailyPlacementProvider);
    final placementNotifier = ref.read(dailyPlacementProvider.notifier);
    final currentRevenue = ref.watch(currentRevenueProvider);
    final appUserAsync = ref.watch(appUserProvider);

    final appUser = appUserAsync.asData?.value;
    final level = appUser?.currentLevel ?? widget.level;
    final streak = appUser?.streak ?? widget.streak;
    final unlockedStalls = appUser?.unlockedStalls ?? widget.unlockedStalls;

    final availableStalls = Stall.defaultStalls.values
        .where((s) => unlockedStalls.contains(s.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🌙 本日の配置'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: RevenueDisplay(
                revenue: currentRevenue,
                level: level,
                streak: streak,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridUI(
                  layout: placementState.layout,
                  stallColors: StallDisplayHelper.stallColors,
                  onCellUpdate: (position, stallId) {
                    placementNotifier.updateCell(position, stallId);
                  },
                ),
              ),
            ),
            StallSelector(
              availableStalls: availableStalls,
              stallColors: StallDisplayHelper.stallColors,
              unlockedStalls: unlockedStalls,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (placementState.isLayoutFull &&
                          !placementState.isConfirmed &&
                          !placementState.isConfirming)
                      ? () async {
                          HapticFeedback.mediumImpact();
                          final previousRevenue = placementState.previousRevenue;
                          await placementNotifier.confirmPlacement();
                          if (context.mounted) {
                            final isAhaMoment = ref.read(ahaMomentProvider);
                            if (isAhaMoment) {
                              _showAhaMomentSnackBar(
                                context,
                                previousRevenue: previousRevenue,
                                currentRevenue: currentRevenue,
                              );
                            } else {
                              _showConfirmedSnackBar(context, currentRevenue);
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    placementState.isConfirmed
                        ? '✅ 確定済み'
                        : (placementState.isLayoutFull ? '配置を確定' : '9マスすべて配置してください'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmedSnackBar(BuildContext context, int revenue) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('配置を確定しました！本日の売上: ¥$revenue'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAhaMomentSnackBar(
    BuildContext context, {
    required int previousRevenue,
    required int currentRevenue,
  }) {
    final diff = currentRevenue - previousRevenue;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 昨日より¥$diff アップ！ (¥$previousRevenue → ¥$currentRevenue)'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.orange.shade700,
      ),
    );
  }
}
