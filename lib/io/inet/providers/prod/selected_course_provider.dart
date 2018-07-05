import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

//TODO implement
class ProdSelectedCourseProvider implements InetSelectedCourseProvider {
  final HttpHelper helper;

  ProdSelectedCourseProvider(this.helper);

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
