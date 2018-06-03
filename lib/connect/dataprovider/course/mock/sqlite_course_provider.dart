import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

class SqliteCourseProvider implements CourseProvider {
  @override
  Future<Course> getCourse(int courseId) async {
    DatabaseHelper dbh = new DatabaseHelper();
    Map<String, dynamic> data =
        await dbh.selectOneWhere("Course", "id", courseId.toString());

    CourseStatus tempCourseStatus;
    String tempCourseStatusName = data["status"];
    tempCourseStatus = tempCourseStatusName == "red"
        ? CourseStatus.RED
        : tempCourseStatusName == "yellow"
            ? CourseStatus.YELLOW
            : CourseStatus.GREEN;
    List<int> courseFacultyAvailableList = [];
    try {
      courseFacultyAvailableList = (data["courseFacultyAvailable"].split(','))
          .map((val) => int.parse(val))
          .toList();
    } catch (e) {
      courseFacultyAvailableList.clear();
    }
    return new Course(
        data['id'],
        data["name"],
        data["location"],
        data["description"],
        data["department"],
        data["lecturerId"],
        data["lecturerName"],
        data["room"],
        tempCourseStatus,
        courseFacultyAvailableList,
        data["availableSlots"],
        data["ects"],
        data["semesterWeekHours"],
        new TimeAndDay(data["duration"], data["day"], data["slot"]));
  }

  @override
  Future<List<Course>> getCourses() async {
    List<Course> courses = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawCampusData = await dbh.selectTable("Course");

    void addCourse(Map<String, dynamic> data) {
      String tempCourseStatusName = data["status"];
      CourseStatus tempCourseStatus = tempCourseStatusName == "red"
          ? CourseStatus.RED
          : tempCourseStatusName == "yellow"
              ? CourseStatus.YELLOW
              : CourseStatus.GREEN;
      List<int> courseFacultyAvailableList = [];
      try {
        courseFacultyAvailableList = (data["courseFacultyAvailable"].split(','))
            .map((val) => int.parse(val))
            .toList();
      } catch (e) {
        courseFacultyAvailableList.clear();
      }
      Course tempCourse = new Course(
          data['id'],
          data["name"],
          data["location"],
          data["description"],
          data["department"],
          data["lecturerId"],
          data["lecturerName"],
          data["room"],
          tempCourseStatus,
          courseFacultyAvailableList,
          data["availableSlots"],
          data["ects"],
          data["semesterWeekHours"],
          new TimeAndDay(data["day"], data["duration"], data["slot"]));

      courses.add(tempCourse);
    }

    rawCampusData.forEach(addCourse);

    return (new Future.delayed(const Duration(seconds: 1), () => courses));
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartment(int department) async {
    List<Course> courses = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawCampusData =
        await dbh.selectWhere("Course", "department", department.toString());

    void addCourse(Map<String, dynamic> data) {
      String tempCourseStatusName = data["status"];
      CourseStatus tempCourseStatus = tempCourseStatusName == "red"
          ? CourseStatus.RED
          : tempCourseStatusName == "yellow"
              ? CourseStatus.YELLOW
              : CourseStatus.GREEN;
      List<int> courseFacultyAvailableList = [];
      try {
        courseFacultyAvailableList = (data["courseFacultyAvailable"].split(','))
            .map((val) => int.parse(val))
            .toList();
      } catch (e) {
        courseFacultyAvailableList.clear();
      }
      Course tempCourse = new Course(
          data['id'],
          data["name"],
          data["location"],
          data["description"],
          data["department"],
          data["lecturerId"],
          data["lecturerName"],
          data["room"],
          tempCourseStatus,
          courseFacultyAvailableList,
          data["availableSlots"],
          data["ects"],
          data["semesterWeekHours"],
          new TimeAndDay(data["day"], data["duration"], data["slot"]));

      courses.add(tempCourse);
    }

    rawCampusData.forEach(addCourse);

    return (new Future.delayed(const Duration(seconds: 1), () => courses));
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartments(
      List<int> departments) async {
    List<Course> courses = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawCampusData = await dbh.selectTable("Course");

    void addCourse(Map<String, dynamic> data) {
      String tempCourseStatusName = data["status"];
      CourseStatus tempCourseStatus = tempCourseStatusName == "red"
          ? CourseStatus.RED
          : tempCourseStatusName == "yellow"
              ? CourseStatus.YELLOW
              : CourseStatus.GREEN;
      List<int> courseFacultyAvailableList = [];
      try {
        courseFacultyAvailableList = (data["courseFacultyAvailable"].split(','))
            .map((val) => int.parse(val))
            .toList();
      } catch (e) {
        courseFacultyAvailableList.clear();
      }
      Course tempCourse = new Course(
          data['id'],
          data["name"],
          data["location"],
          data["description"],
          data["department"],
          data["lecturerId"],
          data["lecturerName"],
          data["room"],
          tempCourseStatus,
          courseFacultyAvailableList,
          data["availableSlots"],
          data["ects"],
          data["semesterWeekHours"],
          new TimeAndDay(data["day"], data["duration"], data["slot"]));

      courses.add(tempCourse);
    }

    rawCampusData.forEach(addCourse);

    return new Future.delayed(
        const Duration(milliseconds: 600),
        () =>
            courses.where((course) => departments.contains(course.department)));
  }

  Future<int> putCourses(List<Course> courses) async {
    List<Map<String, dynamic>> coursesList = [];
    DatabaseHelper dbh = new DatabaseHelper();

    void iterate(Course data) {
      coursesList.add(data.toMap());
    }

    courses.forEach(iterate);

    return dbh.insertTable("Course", coursesList);
  }
}
