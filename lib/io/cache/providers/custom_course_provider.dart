import 'dart:async';

import 'package:courses_in_english/model/course/custom_course.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Provider for courses.
abstract class CacheCustomCourseProvider {
  /// Get all available courses.
  Future<List<CustomCourse>> getCourses(User user);

  Future<int> putCourses(List<CustomCourse> courses, User user);

  Future<int> putCourse(CustomCourse course, User user);

  /// Get course by id.
  Future<CustomCourse> getCourse(int courseId);

  Future<int> getCount(User user);
  Future<bool> deleteCourse(CustomCourse course, User user);
}
