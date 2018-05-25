import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Provider for course selections.
abstract class SelectionProvider {
  /// Try to select a course. Returns whether the course was successfully selected.
  Future<bool> selectCourse(User user, Course course);

  /// Try to deselect a course. Returns whether the course was successfully deselected.
  Future<bool> deselectCourse(User user, Course course);
}
