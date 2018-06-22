import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Provider for courses.
abstract class CacheSelectedCourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses(User user);

  Future<int> putCourses(List<Course> courses, User user);

  Future<int> getCount(User user);

  Future<bool> selectCourse(Course course, User user);

  Future<bool> unSelectCourse(Course course, User user);
}
