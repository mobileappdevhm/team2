import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

class ProdCourseProvider implements InetCourseProvider {
  final HttpHelper helper;

  ProdCourseProvider(this.helper);

  @override
  Future<Course> getCourse(int courseId) {
    throw new UnimplementedError();
  }

  @override
  Future<List<Course>> getCourses() async => helper
      .getCoursesAsJson()
      .then((raw) => parseCourses(raw))
      .then((list) => list.map((c) => c as Course))
      .then((iterable) => iterable.toList());

  Future<List<dynamic>> parseCourses(String raw) async => json.decode(
        raw,
        reviver: (k, v) {
          if (k == 'department') return Department.fromJsonMap(v);
          if (k == 'courseStatus') return stringToStatus(v);
          if (k == 'lecturer') return Lecturer.fromJsonMap(v);
          if (k == 'location') return Campus.fromJsonMap(v);
          if (k == 'courseAppointments') return <TimeAndDay>[];
          if (k is num) return Course.fromJsonMap(v);
          return v;
        },
      );

  @override
  Future<List<Course>> getSelectedCourses() {
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

  @override
  void pushFavorites(List<Course> courses, String token) async {
    helper.pushFavorites(courses, token);
  }
}
