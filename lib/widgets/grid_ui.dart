import 'package:flutter/material.dart';
import 'grid_cell.dart';
import 'package:yoichiyatai/theme/colors.dart';
import 'package:yoichiyatai/utils/stall_display_helper.dart';

class GridUI extends StatefulWidget {
  final Map<int, String> layout; // position -> stallId
  final Map<String, Color> stallColors; // stallId -> color
  final Function(int position, String stallId) onCellUpdate;
  final VoidCallback? onLayoutComplete;

  const GridUI({
    Key? key,
    required this.layout,
    required this.stallColors,
    required this.onCellUpdate,
    this.onLayoutComplete,
  }) : super(key: key);

  @override
  State<GridUI> createState() => _GridUIState();
}

class _GridUIState extends State<GridUI> {
  late Map<int, String> _currentLayout;

  @override
  void initState() {
    super.initState();
    _currentLayout = Map.from(widget.layout);
  }

  @override
  void didUpdateWidget(GridUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.layout != widget.layout) {
      _currentLayout = Map.from(widget.layout);
    }
  }

  void _updateCell(int position, String stallId) {
    setState(() {
      _currentLayout[position] = stallId;
      widget.onCellUpdate(position, stallId);
    });
    if (_isLayoutFull()) {
      widget.onLayoutComplete?.call();
    }
  }

  void _clearCell(int position) {
    setState(() {
      _currentLayout[position] = '';
      widget.onCellUpdate(position, '');
    });
  }

  bool _isLayoutFull() {
    return _currentLayout.values.where((v) => v.isEmpty).isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.nightMarketGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 3×3 Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              final stallId = _currentLayout[index] ?? '';
              final color = stallId.isEmpty
                  ? AppColors.grey200
                  : widget.stallColors[stallId] ?? AppColors.grey400;

              return GestureDetector(
                onLongPress: stallId.isNotEmpty ? () => _clearCell(index) : null,
                child: GridCell(
                  position: index,
                  stallId: stallId.isEmpty ? null : stallId,
                  displayLabel: stallId.isEmpty
                      ? null
                      : StallDisplayHelper.emojiFor(stallId),
                  backgroundColor: color,
                  stallColor: stallId.isEmpty ? null : color,
                  onDragAccept: (draggedStallId) {
                    _updateCell(index, draggedStallId);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Status indicator
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _isLayoutFull()
                  ? '✅ 配置完了'
                  : '配置: ${_currentLayout.values.where((v) => v.isNotEmpty).length}/9',
              style: TextStyle(
                fontSize: 12,
                color: _isLayoutFull()
                    ? Colors.green.shade400
                    : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
