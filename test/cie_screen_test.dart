import 'package:courses_in_english/ui/screens/cie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProgressBarTest', (WidgetTester tester) async {
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('LogoutTest', (WidgetTester tester) async {
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.text("Logout"), findsOneWidget);
    expect(find.widgetWithText(RawMaterialButton, "Logout"), findsOneWidget);
  });

  testWidgets('BarTest', (WidgetTester tester) async {
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.byType(Divider), findsOneWidget);
  });

  testWidgets('AddButtonTest', (WidgetTester tester) async {
    await tester
        .pumpWidget(new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.widgetWithText(RawMaterialButton, "Add CIE"), findsOneWidget);
  });
}
