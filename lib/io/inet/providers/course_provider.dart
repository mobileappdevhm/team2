import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

/// Provider for courses.
abstract class InetCourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses();

  Future<List<Course>> getSelectedCourses();

  Future<bool> selectCourse(Course course);

  Future<bool> unSelectCourse(Course course);

  void pushFavorites(List<Course> courses, String token);

  /// Get course by id.
  Future<Course> getCourse(int courseId);
}
