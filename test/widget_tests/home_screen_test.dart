import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:courses_in_english/ui/screens/sample_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /*
  TODO add ability to test with mockito
  testWidgets('HomeScreenTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold()));
    await tester.idle();
  });
  */

  testWidgets('SampleScreenTest', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new SampleScreen("Test")));
    expect(find.text("Test"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('LoginTest', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(
        find.widgetWithText(RaisedButton, "Continue as Guest"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Login"), findsOneWidget);
  });
}
