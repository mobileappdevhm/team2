import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  testWidgets('Settings test skeleton', (tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new SettingsScreen(),
      ),
    ));
  });
}
