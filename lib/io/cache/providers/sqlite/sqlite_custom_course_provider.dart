import 'dart:async';
import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_department_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_campus_provider.dart';

class SqliteCustomCourseProvider implements CacheCustomCourseProvider {
  final DatabaseHelper dbh;

  SqliteCustomCourseProvider(this.dbh);
  @override
  Future<Course> getCourse(int courseId) async {
    List<TimeAndDay> dates = [];
    Map<String, dynamic> data =
        await dbh.selectOneWhere("CustomCourse", "id", courseId.toString());
    List<Map<String, dynamic>> dateData =
        await dbh.selectWhere("CustomDate", "course", courseId.toString());

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
    List<Map<String, dynamic>> rawCampusData =
        await dbh.selectTable("CustomCourse");

    Future addCourse(Map<String, dynamic> data) async {
      List<TimeAndDay> dates = [];
      List<Map<String, dynamic>> dateData =
          await dbh.selectWhere("CustomDate", "course", data["id"].toString());
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
  Future<int> putCourses(List<Course> courses) => dbh.insertTable(
        "CustomCourse",
        courses.map(
          // Map each course to raw data
          (course) => course.toMap(),
        ),
      ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE? Arnt those going to be put in at the start?

  Future<int> getCount() async {
    return dbh.getCount(
        "CustomCourse"); //TODO:use this to set the ID when making new custom course
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
