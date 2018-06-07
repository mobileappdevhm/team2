import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

/// Provider for courses.
abstract class CourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses();

  Future<List<Course>> getSelectedCourses();
  Future<bool> selectCourse(Course course);
  Future<bool> unSelectCourse(Course course);

  Future<List<Course>> getFavorizedCourses();
  Future<bool> favorizeCourse(Course course);
  Future<bool> unFavorizeCourse(Course course);

  /// Get course by id.
  Future<Course> getCourse(int courseId);
}
