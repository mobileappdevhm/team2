import 'dart:async';

import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';

class InMemoryCourseProvider implements CacheCourseProvider {
  Set<Course> courses = new Set();
  Set<Course> favorites = new Set();
  Set<Course> selected = new Set();
  @override
  Future<bool> favorizeCourse(Course course) async {
    favorites.add(course);
    return true;
  }

  @override
  Future<Course> getCourse(int courseId) async {
    return courses.firstWhere((course) => course.id == courseId);
  }

  @override
  Future<List<Course>> getCourses() async {
    return courses.toList(growable: false);
  }

  @override
  Future<List<Course>> getFavorizedCourses() async {
    return favorites.toList(growable: false);
  }

  @override
  Future<List<Course>> getSelectedCourses() async {
    return selected.toList(growable: false);
  }

  @override
  Future<int> putCourses(List<Course> courses) async {
    this.courses.addAll(courses);
    return 0;
  }

  @override
  Future<bool> selectCourse(Course course) async {
    selected.add(course);
    return true;
  }

  @override
  Future<bool> unFavorizeCourse(Course course) async {
    favorites.remove(course);
    return false;
  }

  @override
  Future<bool> unSelectCourse(Course course) async {
    selected.remove(course);
    return false;
  }

  @override
  Future<int>  truncate(){
    throw new UnimplementedError();
  }
}
