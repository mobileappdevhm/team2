import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Provider for courses.
abstract class CacheCourseProvider {
  /// Get all available courses.
  Future<List<Course>> getCourses();

  Future<List<Course>> getSelectedCourses();

  Future<bool> selectCourse(Course course, User user);

  Future<bool> unSelectCourse(Course course, User user);

  Future<int> putCourses(List<Course> courses);

  Future<List<Course>> getFavorizedCourses(User user);

  Future<bool> favorizeCourse(Course course, User user);

  Future<bool> unFavorizeCourse(Course course, User user);

  /// Get course by id.
  Future<Course> getCourse(int courseId);

  Future<int> truncate();
}
