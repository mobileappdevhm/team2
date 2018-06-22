import 'dart:async';
import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/selected_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_department_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_campus_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class SqliteSelectedCourseProvider implements CacheSelectedCourseProvider {
  final DatabaseHelper dbh;

  SqliteSelectedCourseProvider(this.dbh);

  @override
  Future<List<Course>> getCourses(User user) async {
    List<Course> courses = [];
    List<Map<String, dynamic>> rawCampusData = await dbh.selectWhere(
        "SelectedCourse", "userId", user.id.toString());

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
  Future<int> putCourses(List<Course> courses, User user) async {
    await dbh.insertTable(
      "SelectedCourse",
      courses.map(
        // Map each course to raw data
        (course) => course.toSelectedMap(user),
      ),
    ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE? Arnt those going to be put in at the start?

    ///Make sure the dates are put in Via courses before the selected courses.  Since we dont add dates here
    return new Future(() => 0);
  }

  @override
  Future<bool> selectCourse(Course course, User user) async{
        bool b =
        (0 != await dbh.insertOneTable("SelectedCourses", course.toSelectedMap(user)));
    return (new Future(() => b));
    // TODO: implement selectCourse
  }

  @override
  Future<bool> unSelectCourse(Course course, User user) async {
    bool b = (0 !=
        await dbh.deleteTwoWhere("SelectedCourses", "userId", "courseId",
            user.id.toString(), course.id.toString()));
    return (new Future(() => b));
    // TODO: implement unSelectCourse
  }

  Future<int> getCount(User user) async {
    return dbh.getCount(
        "SelectedCourse"); //TODO:use this to set the ID when making new custom course
  }
}
