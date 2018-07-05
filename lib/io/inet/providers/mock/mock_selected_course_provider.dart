import 'dart:async';

import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';

//TODO implement
class MockInetSelectedCourseProvider implements InetSelectedCourseProvider {
  @override
  Future<List<Course>> getCourses() {
    throw new UnimplementedError();
  }

  @override
  Future<int> putCourses(List<Course> courses) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> selectCourse(Course course) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    throw new UnimplementedError();
  }
}
