import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/ui/screens/cie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProgressBarTest', (WidgetTester tester) async {
    UserSettingsProvider _data = new Data().settingsProvider;
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('LogoutTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.text("Logout"), findsOneWidget);
    expect(find.widgetWithText(RawMaterialButton,"Logout"), findsOneWidget);
  });

  testWidgets('NextPageTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.widgetWithIcon(IconButton, Icons.add), findsOneWidget);
  });

  testWidgets('BarTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new CieScreen())));
    expect(find.byType(Divider), findsOneWidget);
  });
}
