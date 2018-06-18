import 'dart:async';

import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';

class MockInetCustomCourseProvider implements InetCourseProvider {
  static const List<Course> MOCK_COURSES = const <Course>[
    course01,
    course02,
    course03,
    course04,
    course05,
  ];
  Set<Course> favorites = new Set();

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
  Future<bool> favorizeCourse(Course course) {
    return new Future.delayed(
        new Duration(milliseconds: 200), () => favorites.add(course));
  }

  @override
  Future<List<Course>> getFavorizedCourses() async {
    return new Future.delayed(new Duration(milliseconds: 200),
        () => favorites.toList(growable: false));
  }

  @override
  Future<List<Course>> getSelectedCourses() {
    // TODO: implement getSelectedCourses
    return new Future.delayed(new Duration(milliseconds: 200), () => []);
  }

  @override
  Future<bool> selectCourse(Course course) {
    // TODO: implement selectCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unFavorizeCourse(Course course) {
    return new Future.delayed(
        new Duration(milliseconds: 200), () => favorites.remove(course));
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    // TODO: implement unSelectCourse
    throw new UnimplementedError();
  }
}
