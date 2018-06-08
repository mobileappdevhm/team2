import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/ui/basic_components/timetable_entry.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const courses = [
  course01,
  course03,
  course05
];

void main() {
  testWidgets('Test timetable screen', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new TimetableScreen(courses),
      ),
    ));
    expect(find.byType(TimetableEntry), findsNWidgets(3));
  });
  testWidgets('Test timetable entry', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new TimetableEntry(course01, 1),
      ),
    ));
    expect(find.text(course01.name), findsOneWidget);
  });
}