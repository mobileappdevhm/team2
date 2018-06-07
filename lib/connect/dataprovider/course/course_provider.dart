import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

/// Provider for courses.
abstract class CourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses();

  Future<List<Course>> getSelectedCourses();
  Future<bool> selectCourse();
  Future<bool> unSelectCourse();

  Future<List<Course>> getFavorizedCourses();
  Future<bool> favorizeCourse();
  Future<bool> unFavorizeCourse();

  /// Get course by id.
  Future<Course> getCourse(int courseId);
}
