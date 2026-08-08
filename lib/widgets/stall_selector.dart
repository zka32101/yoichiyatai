import 'package:flutter/material.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/theme/colors.dart';
import 'package:yoichiyatai/utils/stall_display_helper.dart';
import 'grid_cell.dart';

class StallSelector extends StatefulWidget {
  final List<Stall> availableStalls;
  final Map<String, Color> stallColors;
  final List<String> unlockedStalls;

  const StallSelector({
    Key? key,
    required this.availableStalls,
    required this.stallColors,
    required this.unlockedStalls,
  }) : super(key: key);

  @override
  State<StallSelector> createState() => _StallSelectorState();
}

class _StallSelectorState extends State<StallSelector> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _isStallUnlocked(String stallId) {
    return widget.unlockedStalls.contains(stallId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final stall in widget.availableStalls)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildStallItem(stall),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStallItem(Stall stall) {
    final isUnlocked = _isStallUnlocked(stall.id);
    final color = widget.stallColors[stall.id] ?? AppColors.grey400;

    return Stack(
      children: [
        // Draggable stall（アンロック時のみ）
        if (isUnlocked)
          DraggableGridCell(
            stallId: stall.id,
            stallName: stall.name,
            stallColor: color,
            displayLabel: StallDisplayHelper.emojiFor(stall.id),
          )
        else
          // Locked stall（グレーアウト）
          Opacity(
            opacity: 0.4,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '🔒',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        // Tooltip with stall info
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Tooltip(
            message: isUnlocked
                ? '${stall.name} (¥${stall.baseRevenue})'
                : '${stall.name} (Lv.${stall.unlockedAtLevel}で解放)',
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
