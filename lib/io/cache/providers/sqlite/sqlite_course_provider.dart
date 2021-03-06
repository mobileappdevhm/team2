import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_department_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

class SqliteCourseProvider implements CacheCourseProvider {
  final DatabaseHelper dbh;

  SqliteCourseProvider(this.dbh);

  @override
  Future<Course> getCourse(int courseId) async {
    List<TimeAndDay> dates = [];
    Map<String, dynamic> data =
        await dbh.selectOneWhere("Course", "id", courseId.toString());
    List<Map<String, dynamic>> dateData =
        await dbh.selectWhere("Date", "course", courseId.toString());

    CourseStatus tempCourseStatus;
    String tempCourseStatusName = data["status"];
    tempCourseStatus = tempCourseStatusName == "red"
        ? CourseStatus.RED
        : tempCourseStatusName == "yellow"
            ? CourseStatus.YELLOW
            : CourseStatus.GREEN;

    Lecturer lecturerData =
        await new SqliteLecturerProvider(dbh).getLecturerById(data["lecturer"]);
    Department departmentData = await new SqliteDepartmentProvider(dbh)
        .getDepartmentByNumber(data["department"]);
    Campus locationData =
        await new SqliteCampusProvider(dbh).getCampusesById(data["location"]);

    void addDate(Map<String, dynamic> data) {
      dates.add(new TimeAndDay(data["id"], data["weekday"], data["startHour"],
          data["startMinute"], data["duration"], data["course"]));
    }

    dateData.forEach(addDate);

    return new Course(
        data['id'],
        data["name"],
        data["description"],
        data["room"],
        data["availableSlots"],
        data["ects"],
        data["usCredits"],
        data["semesterWeekHours"],
        tempCourseStatus,
        lecturerData,
        departmentData,
        locationData,
        dates);
  }

  @override
  Future<List<Course>> getCourses() async {
    List<Course> courses = [];
    List<Map<String, dynamic>> rawCampusData = await dbh.selectTable("Course");

    Future addCourse(Map<String, dynamic> data) async {
      List<TimeAndDay> dates = [];
      List<Map<String, dynamic>> dateData =
          await dbh.selectWhere("Date", "course", data["id"].toString());
      Lecturer lecturerData = await new SqliteLecturerProvider(dbh)
          .getLecturerById(data["lecturer"]);
      Department departmentData = await new SqliteDepartmentProvider(dbh)
          .getDepartmentByNumber(data["department"]);
      Campus locationData =
          await new SqliteCampusProvider(dbh).getCampusesById(data["location"]);
      String tempCourseStatusName = data["status"];
      CourseStatus tempCourseStatus = tempCourseStatusName == "red"
          ? CourseStatus.RED
          : tempCourseStatusName == "yellow"
              ? CourseStatus.YELLOW
              : CourseStatus.GREEN;

      void addDate(Map<String, dynamic> data) {
        dates.add(new TimeAndDay(data["id"], data["weekday"], data["startHour"],
            data["startMinute"], data["duration"], data["course"]));
      }

      dateData.forEach(addDate);

      Course tempCourse = new Course(
          data['id'],
          data["name"],
          data["description"],
          data["room"],
          data["availableSlots"],
          data["ects"],
          data["usCredits"],
          data["semesterWeekHours"],
          tempCourseStatus,
          lecturerData,
          departmentData,
          locationData,
          dates);

      courses.add(tempCourse);
    }

    for (Map<String, dynamic> data in rawCampusData) {
      await addCourse(data);
    }

    return (new Future(() => courses));
//    throw new UnimplementedError();
  }

  @override
  Future<int> putCourses(List<Course> courses) async => dbh.insertTable(
        "Course",
        courses
            .map(
              // Map each course to raw data
              (course) => course.toMap(),
            )
            .toList(),
      ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE?Arnt those going to be put in at the start?

  @override
  Future<bool> favorizeCourse(Course course) async {
    // TODO: implement favorizeCourse
    bool b = (0 == await dbh.insertOneTable("Favorites", course.toMap()));
    return (new Future(() => b));
//    throw new UnimplementedError();
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
  Future<bool> unFavorizeCourse(Course course) async {
    bool b =
        (0 == await dbh.deleteWhere("Favorites", "id", course.id.toString()));
    return (new Future(() => b));
    // TODO: implement unFavorizeCourse
//    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse(Course course) {
    // TODO: implement unSelectCourse
    throw new UnimplementedError();
  }
}
