// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:courses_in_english/main.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeScreenTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new HomeScaffold());

    // Verify that our counter starts at 0.
    /*expect(find.text('Courses'), findsOneWidget);
    expect(find.text('Maps'), findsOneWidget);
    expect(find.text('Timetable'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);*/
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    /* Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); */
  });
}
