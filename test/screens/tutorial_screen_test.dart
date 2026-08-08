import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yoichiyatai/screens/tutorial_screen.dart';
import 'package:yoichiyatai/providers/daily_placement_provider.dart';
import 'package:yoichiyatai/models/stall.dart';
import 'package:yoichiyatai/services/placement_calculator.dart';

void main() {
  group('TutorialScreen', () {
    testWidgets('renders guide banner and grid', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: TutorialScreen()),
        ),
      );

      expect(find.text('🌙 はじめての配置'), findsOneWidget);
      expect(find.textContaining('ドラッグして'), findsOneWidget);
    });

    testWidgets('confirm button disabled until layout full',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: TutorialScreen()),
        ),
      );

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(button.onPressed, isNull);
    });

    test('tutorial 3 stalls guarantee positive revenue', () {
      // yakiNiku + veggie + drink base revenue sum
      final layout = {0: 'yakiNiku', 1: 'veggie', 2: 'drink'};
      final revenue =
          PlacementCalculator.calculateRevenue(layout, Stall.defaultStalls);
      expect(revenue, greaterThan(0));
      expect(revenue, greaterThanOrEqualTo(2300)); // 1000+800+500 minimum
    });
  });
}
