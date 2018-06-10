import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";

void main() {
  testWidgets("testLoginLayout", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(RaisedButton), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(SceneryWidget), findsOneWidget);
    expect(find.byType(LineSeparator), findsOneWidget);
  });

  testWidgets("testLogin", (WidgetTester tester) async {});

  testWidgets("testLoginNoAT", (WidgetTester tester) async {});

  testWidgets("testLoginNoDot", (WidgetTester tester) async {});
  testWidgets("testLogin", (WidgetTester tester) async {});
  testWidgets("testLogin", (WidgetTester tester) async {});
}
