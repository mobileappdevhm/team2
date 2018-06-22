import 'dart:async';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';

class ProdCourseProvider implements InetCourseProvider {
  final HttpHelper helper;

  ProdCourseProvider(this.helper);

  @override
  Future<bool> favorizeCourse(Course course) {
    throw new UnimplementedError();
  }

  @override
  Future<Course> getCourse(int courseId) {
    throw new UnimplementedError();
  }

  @override
  Future<List<Course>> getCourses() async => helper
      .getCourses()
      .then((list) => list.map((course) => parseCourse(course)).toList());

  @override
  Future<List<Course>> getFavorizedCourses() {
    throw new UnimplementedError();
  }

  @override
  Future<List<Course>> getSelectedCourses() {
    throw new UnimplementedError();
  }

  @override
  Future<bool> selectCourse(Course course) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> unFavorizeCourse(Course course) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    throw new UnimplementedError();
  }

  Course parseCourse(Map<String, dynamic> json) {
    Department department = json['department'];
    return new Course(
        json['id'],
        json['name'],
        json['description'],
        json['room'],
        json['availableSlots'],
        json['ects'],
        json['usCredits'],
        json['semesterWeekHours'],
        stringToStatus(json['courseStatus']),
        json['lecturer'],
        new Department(department.id, department.number, department.name,
            department.color),
        null, // TODO
        []);
  }
}
