/*import 'dart:async';

import 'package:courses_in_english/main.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/my_dropdown_button.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:courses_in_english/ui/scaffolds/create_user.dart';*/
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:courses_in_english/ui/screens/sample_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /*
  testWidgets('HomeScreenTest', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold()));
    expect(find.text("Timetable"), findsOneWidget);
    expect(find.text("Favorites"), findsOneWidget);
    expect(find.text("Courses"), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    await tester.idle();
  });*/

  testWidgets('SampleScreenTest', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new SampleScreen("Test")));
    expect(find.text("Test"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  /*
  testWidgets('CreateUserTest', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new CreateUserScreen()));
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(MyDropdownButton), findsOneWidget);
    expect(find.findWidgetWithText(RaisedButton, "Save"), findsOneWidget);
  });*/

  testWidgets('LoginTest', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(
        find.widgetWithText(RaisedButton, "Continue as Guest"), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, "Login"), findsOneWidget);
  });
}
