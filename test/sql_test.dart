//import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/course/custom_course_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
//import 'package:courses_in_english/model/course/course.dart';
//import 'package:courses_in_english/model/course/course_status.dart';
//import 'package:courses_in_english/model/course/time_and_day.dart';
//import 'package:courses_in_english/model/department/department.dart';
//import 'package:courses_in_english/model/lecturer/lecturer.dart';
//import 'package:courses_in_english/model/user/user.dart';
import 'package:test/test.dart';
//import "dart:async";
//import 'package:path_provider/path_provider.dart';

//import 'package:courses_in_english/connect/dataprovider/databasehelper/prod_databasehelper.dart';

void main() {

  /**
   * Set up our data source, as we know it from java tests
   */

  /**
   * Sadly, we cannot test the Factory overall, so that's why we need all the imports.
   */
  test('SQL Mock Factory Test', () {
    /// As Classes are not really types in Dart, we can only test instances using the wrapper
    /*expect(_data.courseProvider, new isInstanceOf<SqliteCourseProvider>());
    expect(_data.lecturerProvider, new isInstanceOf<SqliteLecturerProvider>());
    expect(
        _data.departmentProvider, new isInstanceOf<SqliteDepartmentProvider>());
    expect(_data.userProvider, new isInstanceOf<MockInetUserProvider>());
    expect(_data.campusProvider, new isInstanceOf<SqliteCampusProvider>());*/
  });

/*  test('SQL User Provider Test', () {
    UserProvider userProvider = _data.userProvider;
    User test;
    userProvider.login("test", "test").then((User value) {
      test = value;
      expect(test.id, equals(-1));
      expect(test.department, equals(7));
    });
  });*/

  /**Start of SQL tests*/

  test('SQL Campus Test', () async {
//    SqliteCampusProvider campusProvider = _data.campusProvider;
    List<Campus> campuses = [];
    campuses.add(new Campus(0, "Campus1", "/path/to/image", ""));
    campuses.add(new Campus(1, "Campus2", "/path/to/image2", ""));

//    int res = await campusProvider.putCampuses(campuses);
//    expect(res, 0);
//    print(res);
//    campuses = await campusProvider.getCampuses();
//    expect(campuses, isNotEmpty);
  });

  /*
  test('SQL Campus Provider Test', () {
    CampusProvider campusProvider = _data.campusProvider;
    campusProvider.getCampuses().then((List<Campus> value) {
      expect(value, isNotEmpty);
    });
  });

  test('SQL Course Provider Test', () {
    CourseProvider courseProvider = _data.courseProvider;
    courseProvider.getCourses().then((List<Course> value) {
      expect(value, isNotEmpty);
    });
    Course ref = new Course(
        0,
        "Mobile Application Development",
        "Lothstraße",
        '',
        7,
        0,
        "Socher",
        "R2.016",
        CourseStatus.GREEN,
        const [],
        30,
        5,
        4,
        const TimeAndDay(5, "15:15 - 16:45", 5));
    courseProvider.getCourse(0).then((Course value) {
      expect(ref.id, equals(value.id));
      expect(ref.availableSlots, equals(30));
      expect(ref.lecturerName, equals("Socher"));
      expect(ref.lecturerId, equals(0));
      expect(ref.ects, equals(5));
    });
  });


  test('SQL Department Provider Test', () {
    DepartmentProvider departmentProvider = _data.departmentProvider;
    departmentProvider.getDepartments().then((Iterable<Department> values) {
      expect(values, isNotEmpty);
    });
    departmentProvider.getDepartmentByNumber(1).then((Department value) {
      expect(value.name, equals("Architektur"));
    });
  });



  test('SQL Lecturer Provider Test', () {
    LecturerProvider departmentProvider = _data.lecturerProvider;
    departmentProvider.getLecturerById(0).then((Lecturer value){
      expect(value.email, equals("test@hm.edu"));
      expect(value.name, equalsIgnoringCase("Socher"));
    });
  });    */
}
