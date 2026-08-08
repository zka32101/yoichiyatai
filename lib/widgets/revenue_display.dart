import 'package:flutter/material.dart';
import 'package:yoichiyatai/theme/typography.dart';
import 'package:yoichiyatai/theme/colors.dart';

class RevenueDisplay extends StatefulWidget {
  final int revenue;
  final int level;
  final int streak;
  final bool isAnimating;

  const RevenueDisplay({
    Key? key,
    required this.revenue,
    this.level = 0,
    this.streak = 0,
    this.isAnimating = false,
  }) : super(key: key);

  @override
  State<RevenueDisplay> createState() => _RevenueDisplayState();
}

class _RevenueDisplayState extends State<RevenueDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _revenueAnimation;
  int _displayRevenue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _displayRevenue = widget.revenue;
    _setupAnimation();
  }

  @override
  void didUpdateWidget(RevenueDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.revenue != widget.revenue) {
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    _revenueAnimation = IntTween(
      begin: _displayRevenue,
      end: widget.revenue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _revenueAnimation.addListener(() {
      setState(() => _displayRevenue = _revenueAnimation.value);
    });

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatCurrency(int value) {
    return '¥${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryLight, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 本日の売上
            Text(
              '本日の売上',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            // Revenue number
            Text(
              _formatCurrency(_displayRevenue),
              style: AppTypography.numberLarge.copyWith(
                color: Colors.white,
              ),
            ),
            if (widget.level > 0 || widget.streak > 0) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.level > 0)
                    Chip(
                      label: Text(
                        'Lv.${widget.level}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.black.withOpacity(0.2),
                      padding: EdgeInsets.zero,
                    ),
                  if (widget.level > 0 && widget.streak > 0)
                    const SizedBox(width: 8),
                  if (widget.streak > 0)
                    Chip(
                      label: Text(
                        '🔥 ${widget.streak}日',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.orange.withOpacity(0.3),
                      padding: EdgeInsets.zero,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
