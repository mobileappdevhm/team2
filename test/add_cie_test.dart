import 'package:courses_in_english/ui/screens/add_cie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddButtonTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new AddCieScreen())));
    expect(find.widgetWithText(RawMaterialButton, "Add"), findsOneWidget);
  });

  testWidgets('formTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new AddCieScreen())));
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.widgetWithText(TextFormField, " Input Name"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, " Input Lecturer Name"),
        findsOneWidget);
    expect(find.widgetWithText(TextFormField, " Input Ects (Decimal)"),
        findsOneWidget);
    expect(find.widgetWithText(TextFormField, " Input Department (Integer)"),
        findsOneWidget);
  });

  testWidgets('form2Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new AddCieScreen())));
    await tester.pump(new Duration(milliseconds: 5000));

    Finder finder = find.widgetWithText(TextFormField, " Input Name");
    await tester.enterText(finder, "name");
    finder = find.widgetWithText(TextFormField, " Input Lecturer Name");
    await tester.enterText(finder, "Lect");
    finder = find.widgetWithText(TextFormField, " Input Ects (Decimal)");
    await tester.enterText(finder, "2.0");
    finder = find.widgetWithText(TextFormField, " Input Department (Integer)");
    await tester.enterText(finder, "1");
    finder = find.widgetWithText(RawMaterialButton, "Add");
    await tester.tap(finder);
    await tester.pump(new Duration(milliseconds: 5000));
//    expect(find.text("Succesfully added \"name\""), findsOneWidget);
    //TODO: figure out why wait is not happening for setState to finish
  });
}
