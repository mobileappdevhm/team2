import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/selection_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Mock selection provider.
class MockSelectionProvider implements SelectionProvider {
  @override
  Future<bool> deselectCourse(User user, Course course) async {
    print("${user.username} deselects course ${course.name}");

    return true;
  }

  @override
  Future<bool> selectCourse(User user, Course course) async {
    print("${user.username} selects course ${course.name}");

    return true;
  }
}
