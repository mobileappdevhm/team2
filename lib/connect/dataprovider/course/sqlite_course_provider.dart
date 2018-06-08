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

    return (new Future( () => courses));
  */
    throw new UnimplementedError();
  }

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
    throw new UnimplementedError();
  }

  @override
  Future<bool> favorizeCourse(Course course) {
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
  Future<bool> selectCourse(Course course) {
    // TODO: implement selectCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unFavorizeCourse(Course course) {
    // TODO: implement unFavorizeCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    // TODO: implement unSelectCourse
    throw new UnimplementedError();
  }
}
