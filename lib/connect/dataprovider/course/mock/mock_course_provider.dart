import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';

class MockCourseProvider implements CourseProvider {
  static const List<Course> MOCK_COURSES = const <Course>[
    course01,
    course02,
    course03,
    course04,
    course05,
  ];

  @override
  Future<Course> getCourse(int courseId) async {
    return new Future.delayed(
        const Duration(milliseconds: 300), () => MOCK_COURSES[courseId]);
  }

  @override
  Future<List<Course>> getCourses() async {
    return new Future.delayed(
        const Duration(milliseconds: 700), () => MOCK_COURSES);
  }

  @override
  Future<bool> favorizeCourse() {
    // TODO: implement favorizeCourse
    throw new UnimplementedError();
  }

  @override
  Future<List<Course>> getFavorizedCourses() {
    // TODO: implement getFavorizedCourses
    throw new UnimplementedError();

  }

  @override
  Future<List<Course>> getSelectedCourses() {
    // TODO: implement getSelectedCourses
    throw new UnimplementedError();
  }

  @override
  Future<bool> selectCourse() {
    // TODO: implement selectCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unFavorizeCourse() {
    // TODO: implement unFavorizeCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse() {
    // TODO: implement unSelectCourse
    throw new UnimplementedError();
  }
}
