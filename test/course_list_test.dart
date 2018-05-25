import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';

// Future pause(Duration d) => new Future.delayed(d);

void main() {
  final MockCourseProvider courseProvider = new MockCourseProvider();
  final Future<List<Course>> courses_future = courseProvider.getCourses();
  List<Course> courses;

  testWidgets('Test Course List Item Informations',
      (WidgetTester tester) async {
    await courses_future.then((value) {
      courses = value;
    });

    await tester.pumpWidget(
        new MaterialApp(
          home: new CourseListScreen(courses),
        ),
        new Duration(seconds: 1));

    print("Yay");
    // await pause(const Duration(milliseconds: 800));

    for (var course in courses) {
      expect(find.text(course.name), findsOneWidget);
      expect(find.text(course.lecturerName), findsOneWidget);
      expect(find.text("FK " + course.department.toString()), findsOneWidget);
    }
  });

  testWidgets('Test Course List Item favorite mechanism',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseListScreen(courses),
      ),
    );

    print("YAY2");
    // await pause(const Duration(milliseconds: 800));

    expect(find.byIcon(Icons.favorite_border), findsNWidgets(courses.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(courses.length - 1));
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(courses.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
