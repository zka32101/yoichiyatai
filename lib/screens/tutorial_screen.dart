import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/providers/daily_placement_provider.dart';
import 'package:yoichiyatai/utils/stall_display_helper.dart';
import 'package:yoichiyatai/widgets/grid_ui.dart';
import 'package:yoichiyatai/widgets/revenue_display.dart';
import 'package:yoichiyatai/widgets/stall_selector.dart';
import 'home_screen.dart';

// チュートリアル用の3屋台。基礎売上合計は必ず黒字になる想定
// yakiNiku(1000) + veggie(800) + drink(500) = 2300 が最低ライン
const List<String> tutorialStalls = ['yakiNiku', 'veggie', 'drink'];

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  int _step = 0;

  static const List<String> _stepMessages = [
    '屋台を下からドラッグして\nマスに配置しましょう',
    '隣り合う屋台の相性で\n売上がアップします',
    '9マスすべて埋めたら\n「配置を確定」を押しましょう',
  ];

  void _nextStep() {
    if (_step < _stepMessages.length - 1) {
      setState(() => _step++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final placementState = ref.watch(dailyPlacementProvider);
    final placementNotifier = ref.read(dailyPlacementProvider.notifier);
    final currentRevenue = ref.watch(currentRevenueProvider);

    final availableStalls = Stall.defaultStalls.values
        .where((s) => tutorialStalls.contains(s.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🌙 はじめての配置'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildGuideBanner(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: RevenueDisplay(revenue: currentRevenue),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridUI(
                  layout: placementState.layout,
                  stallColors: StallDisplayHelper.stallColors,
                  onCellUpdate: (position, stallId) {
                    placementNotifier.updateCell(position, stallId);
                    _nextStep();
                  },
                ),
              ),
            ),
            StallSelector(
              availableStalls: availableStalls,
              stallColors: StallDisplayHelper.stallColors,
              unlockedStalls: tutorialStalls,
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
                          await placementNotifier.confirmPlacement();
                          if (context.mounted) {
                            _completeTutorial(context, currentRevenue);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(
                    placementState.isLayoutFull ? '配置を確定' : '9マスすべて配置してください',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.amber.shade50,
      child: Text(
        _stepMessages[_step],
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void _completeTutorial(BuildContext context, int revenue) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('🎉 初日の配置完了！'),
        content: Text(
          '本日の売上: ¥$revenue\n\n'
          '毎日配置を変えて、売上アップを目指しましょう！',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: const Text('ホームへ'),
          ),
        ],
      ),
    );
  }
}
