import 'dart:async';

import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';

//TODO implement
class MockInetSelectedCourseProvider implements InetSelectedCourseProvider {
  @override
  Future<List<Course>> getCourses() {
    // TODO: implement getCourses
  }

  @override
  Future<int> putCourses(List<Course> courses) {
    // TODO: implement putCourses
  }

  @override
  Future<bool> selectCourse(Course course) {
    // TODO: implement selectCourse
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    // TODO: implement unSelectCourse
  }
}
