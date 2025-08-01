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
  testWidgets('Splash screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that KOFUKU logo is displayed on splash screen
    expect(find.text('KOFUKU'), findsOneWidget);
    expect(find.text('その服に、あなたの"愛"は\nありますか？'), findsOneWidget);
    expect(find.text('HOSPITALITY IS BEAUTY'), findsOneWidget);
  });

  testWidgets('Welcome page displays after splash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for splash screen animation to complete and navigate to welcome
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verify welcome page elements
    expect(find.text('あなたの愛の物語を\n共有しませんか？'), findsOneWidget);
    expect(find.text('会員登録'), findsOneWidget);
    expect(find.text('ログイン'), findsOneWidget);
  });

  testWidgets('Navigation from welcome to signup works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for welcome page
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Tap signup button
    await tester.tap(find.text('会員登録'));
    await tester.pumpAndSettle();

    // Verify signup page elements
    expect(find.text('会員登録'), findsWidgets);
    expect(find.text('かんたん登録'), findsOneWidget);
    expect(find.text('Apple でサインアップ'), findsOneWidget);
  });

  testWidgets('Navigation from welcome to login works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for welcome page
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Tap login button
    await tester.tap(find.text('ログイン'));
    await tester.pumpAndSettle();

    // Verify login page elements
    expect(find.text('ログイン'), findsWidgets);
    expect(find.text('メールアドレスとパスワードを\n入力してください'), findsOneWidget);
  });
}
