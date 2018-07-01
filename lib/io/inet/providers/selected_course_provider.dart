import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

/// Provider for courses.
abstract class InetSelectedCourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses();

  Future<int> putCourses(List<Course> courses);

  Future<bool> selectCourse(Course course);

  Future<bool> unSelectCourse(Course course);
}
