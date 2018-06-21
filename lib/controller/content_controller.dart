import 'dart:async';

import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Controller for accessing and caching information which is available to both
/// guests and registered users.
abstract class ContentController {
  Future<bool> get offlineMode;

  /// Get all public content.
  Future<Content> getContent();

  Future<List<Course>> getCourses();
  Future<List<Campus>> getCampuses();
  Future<List<Department>> getDepartments();
  Future<List<Lecturer>> getLecturers();
}
