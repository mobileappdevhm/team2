import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/scaffolds/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Course course = new Course(
  0, // Course id
  "Test course", // Course name
  "test", // Location
  "Lorem ipsum dolor sit amet.", // Description
  7, // department
  0, // lecturer id
  'Mustermann', // lecturer name
  'R1.337', // room
  CourseStatus.GREEN, // course status
  [], // courseFacultyAvailable dafuq
  0, // available slots
  5, // ects credits
  4, // semester week hours
    const [
      const TimeAndDay(5, "15:15 - 16:45", 15, 15),
      const TimeAndDay(2, "10:00 - 11:30", 10, 0)
    ], // time and day
);
Department department = new Department(
  7,
  "Computer Science and Mathematics",
  const Color(0xFF029fd0),
);

void main() {
  testWidgets('Test information display', (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course, department),
      ),
    );

    // Search course name
    expect(find.text(course.name), findsOneWidget);
    // Search course description
    expect(find.text(course.description), findsOneWidget);
    // Search department number
    expect(
      find.text('Department ${department.number.toString().padLeft(2, '0')}'),
      findsOneWidget,
    );
    // Search professor name
    expect(find.text(course.lecturerName), findsOneWidget);
  });

  testWidgets('Test favorite mechaninism', (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course, department),
      ),
    );

    // TODO rewrite providers to use mockito
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
