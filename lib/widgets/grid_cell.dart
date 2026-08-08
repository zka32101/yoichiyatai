import 'package:flutter/material.dart';

class GridCell extends StatefulWidget {
  final int position; // 0-8
  final String? stallId;
  final String? displayLabel; // 絵文字など。未指定ならstallIdの頭文字
  final VoidCallback? onTap;
  final Function(String stallId)? onDragAccept;
  final Color backgroundColor;
  final Color? stallColor;

  const GridCell({
    Key? key,
    required this.position,
    this.stallId,
    this.displayLabel,
    this.onTap,
    this.onDragAccept,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.stallColor,
  }) : super(key: key);

  @override
  State<GridCell> createState() => _GridCellState();
}

class _GridCellState extends State<GridCell> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  bool _isDragOver = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (data) {
        setState(() => _isDragOver = true);
        return true;
      },
      onLeave: (data) {
        setState(() => _isDragOver = false);
      },
      onAccept: (stallId) {
        setState(() => _isDragOver = false);
        widget.onDragAccept?.call(stallId);
      },
      builder: (context, candidateData, rejectedData) {
        return ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 0.95).animate(_scaleController),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: _isDragOver
                    ? (widget.stallColor ?? widget.backgroundColor).withOpacity(0.7)
                    : (widget.stallId == null
                        ? widget.backgroundColor
                        : widget.stallColor ?? widget.backgroundColor),
                border: Border.all(
                  color: _isDragOver
                      ? Colors.blue.shade400
                      : Colors.grey.shade300,
                  width: _isDragOver ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: widget.stallId == null
                  ? const SizedBox.expand()
                  : Center(
                      child: Text(
                        widget.displayLabel ??
                            widget.stallId!.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: widget.displayLabel != null ? 18 : 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

// Draggable ラッパー
class DraggableGridCell extends StatelessWidget {
  final String stallId;
  final String stallName;
  final Color stallColor;
  final String? displayLabel;

  const DraggableGridCell({
    Key? key,
    required this.stallId,
    required this.stallName,
    required this.stallColor,
    this.displayLabel,
  }) : super(key: key);

  Widget _buildLabel() {
    return Text(
      displayLabel ?? stallId.substring(0, 1).toUpperCase(),
      style: TextStyle(
        fontSize: displayLabel != null ? 18 : 10,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: stallId,
      feedback: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: stallColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(child: _buildLabel()),
      ),
      childWhenDragging: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: stallColor.withOpacity(0.3),
          border: Border.all(color: Colors.grey.shade400, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: stallColor,
          border: Border.all(color: Colors.grey.shade400, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: _buildLabel()),
      ),
    );
  }
}
