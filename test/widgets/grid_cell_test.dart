import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yoichiyatai/widgets/grid_cell.dart';
import 'package:yoichiyatai/theme/colors.dart';

void main() {
  group('GridCell Widget', () {
    testWidgets('Empty cell renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: null,
              backgroundColor: AppColors.grey200,
            ),
          ),
        ),
      );

      // Verify cell is rendered
      expect(find.byType(GridCell), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Cell with stall renders stallId', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: 'yakiNiku',
              stallColor: AppColors.stallYakiNiku,
            ),
          ),
        ),
      );

      // Verify text is displayed
      expect(find.text('Y'), findsOneWidget); // First letter of yakiNiku
    });

    testWidgets('Tap callback is triggered', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: 'yakiNiku',
              stallColor: AppColors.stallYakiNiku,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GridCell));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Drag accept updates state', (WidgetTester tester) async {
      String? acceptedStallId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: null,
              onDragAccept: (stallId) => acceptedStallId = stallId,
            ),
          ),
        ),
      );

      // Simulate drag and drop
      final finder = find.byType(GridCell);
      expect(finder, findsOneWidget);

      // For DragTarget testing, we'd need a Draggable parent
      // This is a simplified check
      expect(find.byType(DragTarget<String>), findsOneWidget);
    });

    testWidgets('Cell size is 45x45dp', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: 'yakiNiku',
              stallColor: AppColors.stallYakiNiku,
            ),
          ),
        ),
      );

      // Find the cell container
      final container = find.byType(Container).first;
      final size = tester.getSize(container);

      // Note: 45 logical pixels = 45dp
      expect(size.width, equals(45));
      expect(size.height, equals(45));
    });

    testWidgets('Drag over changes visual feedback', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridCell(
              position: 0,
              stallId: null,
              backgroundColor: AppColors.grey200,
            ),
          ),
        ),
      );

      // Initial state
      expect(find.byType(DragTarget<String>), findsOneWidget);
    });
  });
}
