import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yoichiyatai/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: YoichiyataiApp()),
    );

    expect(find.text('夜市の屋台街'), findsOneWidget);
    expect(find.text('Night Market Tycoon'), findsOneWidget);

    // SplashScreen の Future.delayed(2秒) を消化してタイマー残留を防ぐ
    await tester.pump(const Duration(seconds: 3));
  });
}
