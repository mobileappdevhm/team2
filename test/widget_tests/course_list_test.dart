import 'package:courses_in_english/model/course/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/io/mock_data.dart';

const MOCK_COURSES = [course01, course02, course03, course04, course05];

const FAVS = <Course>[];

void main() {
  testWidgets('Test Course List Item Informations',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new CourseListScreen(MOCK_COURSES, FAVS),
    ));

    for (var course in MOCK_COURSES) {
      expect(find.text(course.name), findsOneWidget);
      expect(
          find.text("Department " +
              course.department.number.toString().padLeft(2, '0')),
          findsOneWidget);
    }
  });

/*  testWidgets('Test Course List Item favorite mechanism',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseListScreen(MOCK_COURSES, FAVS),
      ),
    );

    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border),
        findsNWidgets(MOCK_COURSES.length - 1));
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
  }); */
}
