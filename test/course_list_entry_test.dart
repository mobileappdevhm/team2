import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  testWidgets('Test course list entry - favorite false', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new CourseListEntry(course01, false),
      ),
    ));
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
  testWidgets('Test course list entry - favorite true', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new CourseListEntry(course01, true),
      ),
    ));
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
}