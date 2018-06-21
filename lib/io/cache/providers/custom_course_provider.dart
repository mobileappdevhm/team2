import 'dart:async';

import 'package:courses_in_english/model/course/custom_course.dart';

/// Provider for courses.
abstract class CacheCustomCourseProvider {
  /// Get all available courses.
  Future<List<CustomCourse>> getCourses();

  Future<int> putCourses(List<CustomCourse> courses);

  Future<int> putCourse(CustomCourse course);

  /// Get course by id.
  Future<CustomCourse> getCourse(int courseId);

  Future<int> getCount();
  Future<bool> deleteCourse(CustomCourse course);
}
