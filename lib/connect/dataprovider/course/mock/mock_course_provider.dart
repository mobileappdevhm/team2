import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';

class MockCourseProvider implements CourseProvider {
  static const List<Course> MOCK_COURSES = const <Course>[
    course01,
    course02,
    course03,
    course04,
    course05,
  ];

  @override
  Future<Course> getCourse(int courseId) async {
    return new Future.delayed(
        const Duration(milliseconds: 300), () => MOCK_COURSES[courseId]);
  }

  @override
  Future<List<Course>> getCourses() async {
    return new Future.delayed(
        const Duration(milliseconds: 700), () => MOCK_COURSES);
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartment(int department) async {
    return new Future.delayed(
        const Duration(milliseconds: 500),
        () => MOCK_COURSES
            .where((course) => course.department.number == department));
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartments(
      List<int> departments) async {
    return new Future.delayed(
        const Duration(milliseconds: 600),
        () => MOCK_COURSES
            .where((course) => departments.contains(course.department)));
  }
}
