import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';

// Future pause(Duration d) => new Future.delayed(d);

void main() {
  Data data = new Data();
  Future<List<Course>> course_future = data.courseProvider.getCourses();
  Future<Iterable<Department>> department_future =
      data.departmentProvider.getDepartments();
  List<Course> courses;
  Iterable<Department> departments;

  testWidgets('Test Course List Item Informations',
      (WidgetTester tester) async {

    // not working, dunno why
    //await data.courseProvider.getCourses().then((value) {
    await course_future.then((value) {
      courses = value;
    });

    // not working, dunno why
    //await data.departmentProvider.getDepartments().then((value) {
    await department_future.then((value) {
      departments = value;
    });

    print("reaching");
    await tester.pumpWidget(new MaterialApp(
      home: new CourseListScreen(courses, departments),
    ));
    print("not reaching");

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
        home: new CourseListScreen(courses, departments),
      ),
    );

    print("YAY3");
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
