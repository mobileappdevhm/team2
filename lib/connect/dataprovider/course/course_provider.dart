import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

/// Provider for courses.
abstract class CourseProvider {

  /// Get all available courses.
  Future<List<Course>> getCourses();

  /// Get all available courses for one department.
  Future<Iterable<Course>> getCoursesByDepartment(int department);

  /// Get all available courses for one or more departments.
  Future<Iterable<Course>> getCoursesByDepartments(List<int> departments);

  /// Get course by id.
  Future<Course> getCourse(int courseId);

}