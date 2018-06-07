import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

class SqliteCourseProvider implements CourseProvider {
  @override
  Future<Course> getCourse(int courseId) async {
    // TODO adjust to new data model
    /*DatabaseHelper dbh = new DatabaseHelper();
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
  */
    return null;
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartment(int department) async {
    // TODO Adjust to new data model
    /*List<Course> courses = [];
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
  */
    return null;
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartments(
          List<int> departments) async =>
      new DatabaseHelper().selectTable("Course").then(
            (rawData) => rawData.map(
                  // map each raw element into a course object
                  (rawElement) => new Course(
                        rawElement['id'],
                        rawElement['name'],
                        rawElement['description'],
                        rawElement['room'],
                        rawElement['availableSlots'],
                        rawElement['ects'],
                        rawElement['us'],
                        rawElement['semesterWeekHours'],
                        null, // TODO get timeandday
                        stringToStatus(rawElement['status']),
                        null, // TODO get lecturer
                        null, // TODO get department
                        null, // TODO get location
                      ),
                ),
          );

  Future<int> putCourses(List<Course> courses) async =>
      new DatabaseHelper().insertTable(
        "Course",
        courses.map(
          // Map each course to raw data
          (course) => course.toMap(),
        ),
      );

  @override
  Future<List<Course>> getCourses() {
    // TODO: implement getCourses
    return null;
  }
}
