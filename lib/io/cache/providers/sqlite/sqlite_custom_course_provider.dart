import 'dart:async';
import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/model/course/custom_course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/user/user.dart';

class SqliteCustomCourseProvider implements CacheCustomCourseProvider {
  final DatabaseHelper dbh;

  SqliteCustomCourseProvider(this.dbh);
  @override
  Future<CustomCourse> getCourse(int courseId) async {
    List<TimeAndDay> dates = [];
    Map<String, dynamic> data =
        await dbh.selectOneWhere("CustomCourse", "id", courseId.toString());
    List<Map<String, dynamic>> dateData =
        await dbh.selectWhere("CustomDate", "course", courseId.toString());

    void addDate(Map<String, dynamic> data) {
      dates.add(new TimeAndDay(data["id"], data["weekday"], data["startHour"],
          data["startMinute"], data["duration"], data["course"]));
    }

    dateData.forEach(addDate);

    return new CustomCourse(data["name"], data["room"],
        data["lecturer"], data["department"], data["location"], dates, id: data['id']);
  }

  @override
  Future<List<CustomCourse>> getCourses(User user) async {
    List<CustomCourse> courses = [];
    List<Map<String, dynamic>> rawCampusData = await dbh.selectWhere(
        "CustomCourse", "userId", user.id.toString());

    Future addCourse(Map<String, dynamic> data) async {
      List<TimeAndDay> dates = [];
      List<Map<String, dynamic>> dateData =
          await dbh.selectWhere("CustomDate", "course", data["id"].toString());

      void addDate(Map<String, dynamic> data) {
        dates.add(new TimeAndDay(data["id"], data["weekday"], data["startHour"],
            data["startMinute"], data["duration"], data["course"]));
      }

      dateData.forEach(addDate);

      CustomCourse tempCourse = new CustomCourse(
          data["name"],
          data["room"],
          data["lecturer"],
          data["department"],
          data["location"],
          dates,
          id: data["id"]
      );

      courses.add(tempCourse);
    }

    for (Map<String, dynamic> data in rawCampusData) {
      await addCourse(data);
    }

    return (new Future(() => courses));
//    throw new UnimplementedError();
  }

  @override
  Future<int> putCourses(List<CustomCourse> courses, User user) async {
    await dbh.insertTable(
      "CustomCourse",
      courses.map(
        // Map each course to raw data
        (course) => course.toMap(user),
      ),
    ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE? Arnt those going to be put in at the start?
    for (CustomCourse c in courses) {
      await dbh.insertTable(
        "CustomDate",
        c.dates.map((date) => date.toMap()),
      );
    }
    return new Future(() => 0);
  }

  @override
  Future<int> putCourse(CustomCourse course, User user) async {
    await dbh.insertOneTable(
      "CustomCourse",
      course.toMap(user),
    ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE? Arnt those going to be put in at the start?
    await dbh.insertTable(
      "CustomDate",
      course.dates.map((date) => date.toCustomMap(user)),
    );
    return new Future(() => 0);
  }

  @override
  Future<int> getCount(User user) async {
    return dbh.getCount(
        "CustomCourse"); //TODO:use this to set the ID when making new custom course
  }

  Future<bool> deleteCourse(CustomCourse course, User user) async {
    bool res = 0 !=
        await dbh.deleteTwoWhere("CustomCourse", "id", "userId",
            course.id.toString(), user.id.toString());
    bool res2 = 0 !=
        await dbh.deleteTwoWhere("CustomDate", "course", "userId",
            course.id.toString(), user.id.toString());
    return (res == true && res2 == true);
  }
}
