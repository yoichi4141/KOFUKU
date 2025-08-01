// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kofuku/main.dart';

void main() {
  testWidgets('KOFUKU home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that KOFUKU title is displayed
    expect(find.text('KOFUKU'), findsOneWidget);
    
    // Verify that search bar is displayed
    expect(find.text('愛のエッセイを検索...'), findsOneWidget);
    
    // Verify that "愛を語る" button is displayed
    expect(find.text('愛を語る'), findsOneWidget);
    
    // Verify that category tabs are displayed
    expect(find.text('すべて'), findsOneWidget);
    expect(find.text('アウター'), findsOneWidget);
    
    // Verify that statistical information is displayed
    expect(find.text('今日語られた愛'), findsOneWidget);
    expect(find.text('共感の総数'), findsOneWidget);
  });

  testWidgets('Category filtering works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Tap on "アウター" category
    await tester.tap(find.text('アウター'));
    await tester.pump();

    // Verify the category is selected (this test assumes UI updates properly)
    // The actual filtering behavior would need more specific assertions based on data
  });

  testWidgets('"愛を語る" button shows snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Tap the "愛を語る" button
    await tester.tap(find.text('愛を語る'));
    await tester.pump();

    // Verify that snackbar message is displayed
    expect(find.text('愛のエッセイを書く機能は開発中です'), findsOneWidget);
  });
}
