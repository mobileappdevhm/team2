import 'dart:async';
import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_department_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
//import 'package:courses_in_english/model/course/custom_course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/model/user/user.dart';

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
      String tempCourseStatusName = data["courseStatus"];
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
  Future<int> putCourses(List<Course> courses) async {
    await dbh.insertTable(
      "Course",
      courses
          .map(
            // Map each course to raw data
            (course) => course.toMap(),
          )
          .toList(),
    ); //TODO:DO WE NEED TO PUT LECTURERS, DEPARTMENTS, AND CAMPUSES FROM HERE? Arnt those going to be put in at the start?
    for (Course c in courses) {
//      for(TimeAndDay t in c.dates){
//        if((await dbh.selectOneWhere("Date", "id", t.id.toString())).length == 0){
//        await dbh.insertOneTable("Date", t.toMap());
      await dbh.insertTable("Date", c.dates.map((t) => t.toMap()).toList());
//        }
//        try{
//          await dbh.selectOneWhere("Date", "id", t.id.toString());
//        }catch(e){
//          await dbh.insertOneTable("Date", t.toMap());
//        }
//      }
    }
    return new Future(() => 0);
  }

  @override
  Future<bool> favorizeCourse(Course course, User user) async {
    // TODO: implement favorizeCourse
    bool b = (0 !=
        await dbh.insertOneTable("Favorites", course.toFavoritesMap(user)));
    return (new Future(() => b));
//    throw new UnimplementedError();
  }

  @override
  Future<List<Course>> getFavorizedCourses(User user) async {
    List<Course> favs = [];
    if (user == null) {
      return (new Future(() => favs));
    }
    List<Map<String, dynamic>> rawCourseData =
        await dbh.selectWhere("Favorites", "userId", user.id.toString());

    void iterate(Map<String, dynamic> data) async {
      favs.add(await getCourse(data["courseId"]));
    }

    for (Map<String, dynamic> course in rawCourseData) {
      iterate(course);
    }

    return (new Future(() => favs));
  }

  @override
  Future<List<Course>> getSelectedCourses() {
    // TODO: implement getSelectedCourses
    throw new UnimplementedError();
  }

  @override
  Future<bool> selectCourse(Course course, User user) {
    // TODO: implement selectCourse
    throw new UnimplementedError();
  }

  @override
  Future<bool> unFavorizeCourse(Course course, User user) async {
    bool b = (0 !=
        await dbh.deleteTwoWhere("Favorites", "userId", "courseId",
            user.id.toString(), course.id.toString()));
    return (new Future(() => b));
    // TODO: implement unFavorizeCourse
//    throw new UnimplementedError();
  }

  @override
  Future<bool> unSelectCourse(Course course, User user) {
    // TODO: implement unSelectCourse
    throw new UnimplementedError();
  }

  Future<int> truncate() {
    dbh.truncateTable("Date");
    dbh.truncateTable("Course");
    dbh.truncateTable("Favorites");
    return new Future(() => 0);
  }
}
