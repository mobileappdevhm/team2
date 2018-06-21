import 'dart:async';

import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';

class InMemoryCustomCourseProvider implements CacheCustomCourseProvider {
  @override
  Future<bool> favorizeCourse(Course course) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<Course> getCourse(int courseId) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<List<Course>> getCourses() {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<List<Course>> getFavorizedCourses() {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<List<Course>> getSelectedCourses() {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<int> putCourses(List<Course> courses) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<bool> selectCourse(Course course) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<bool> unFavorizeCourse(Course course) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    throw new UnimplementedError(
        'InMemoryCustomCourseProvider not implemented');
  }
}
