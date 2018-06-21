import 'dart:async';

import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/campus_provider.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/department_provider.dart';
import 'package:courses_in_english/io/inet/providers/lecturer_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

import 'package:courses_in_english/io/mock_data.dart';

/// Controller for accessing and caching information which is available to both
/// guests and registered users.
class ContentController {
  // Singleton
  static final _instance = new ContentController._internal();
  factory ContentController() => _instance;
  ContentController._internal();

  // TODO implement offline mode
//  Future<bool> get offlineMode async => false;
  Future<bool> get offlineMode async => true;

  InetCourseProvider _inetCourseProvider;
  InetLecturerProvider _inetLecturerProvider;
  InetDepartmentProvider _inetDepartmentProvider;
  InetCampusProvider _inetCampusProvider;

  CacheCourseProvider _cacheCourseProvider;
  CacheLecturerProvider _cacheLecturerProvider;
  CacheDepartmentProvider _cacheDepartmentProvider;
  CacheCampusProvider _cacheCampusProvider;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory) {
    _inetCampusProvider = inetProviderFactory.createCampusProvider();
    _inetCourseProvider = inetProviderFactory.createCourseProvider();
    _inetDepartmentProvider = inetProviderFactory.createDepartmentProvider();
    _inetLecturerProvider = inetProviderFactory.createLecturerProvider();

    _cacheLecturerProvider = cacheProviderFactory.createLecturerProvider();
    _cacheDepartmentProvider = cacheProviderFactory.createDepartmentProvider();
    _cacheCourseProvider = cacheProviderFactory.createCourseProvider();
    _cacheCampusProvider = cacheProviderFactory.createCampusProvider();

  }

  Future<int> putFakeData() async{
    await _cacheLecturerProvider.truncate();
    await _cacheDepartmentProvider.truncate();
    await _cacheCampusProvider.truncate();
    await _cacheCourseProvider.truncate();

    int r1 = await _cacheLecturerProvider.putLecturers([lecturer01,lecturer02,lecturer03,lecturer04,lecturer05]);
    int r2 = await _cacheCampusProvider.putCampuses([campus01,campus02,campus03]);
    int r4 = await _cacheDepartmentProvider.putDepartments([department01,department02,department03,department04,department05,department06,department07,department08,department09,department10,department11,department12,department13,department14]);
    int r3 = await _cacheCourseProvider.putCourses([course01,course02,course03,course04,course05]);

    return (new Future( () => 0 ));
  }

  /// Get all public content.
  Future<Content> getContent() async {
    await putFakeData();
    Content content = new Content();
    content.campuses = await getCampuses();
    content.courses = await getCourses();
    content.departments = await getDepartments();
    content.lecturers = await getLecturers();
    return content;
  }

  Future<List<Course>> getCourses() async {
//    if (!await offlineMode) {
////      List<Course> courses = await _cacheCourseProvider.getCourses();
//      List<Course> courses = await _inetCourseProvider.getCourses(); //TODO: DECIDE WHERE INFO SHOULD COME FROM?
//      // await _cacheCourseProvider.putCourses(courses);
//      return courses;
//    }
    return _cacheCourseProvider.getCourses();
  }

  Future<List<Campus>> getCampuses() async {
//    if (!await offlineMode) {
////      List<Campus> campuses = await _cacheCampusProvider.getCampuses();
//      List<Campus> campuses = await _inetCampusProvider.getCampuses();//TODO: DECIDE WHERE INFO SHOULD COME FROM?
//      // await _cacheCampusProvider.putCampuses(campuses);
//      return campuses;
//    }
    return _cacheCampusProvider.getCampuses();
  }

  Future<List<Department>> getDepartments() async {
//    if (!await offlineMode) {
////      List<Department> departments =
////          await _cacheDepartmentProvider.getDepartments();
//      List<Department> departments =
//        await _inetDepartmentProvider.getDepartments();//TODO: DECIDE WHERE INFO SHOULD COME FROM?
//      // await _cacheDepartmentProvider.putDepartments(departments);
//      return departments;
//    }
    return _cacheDepartmentProvider.getDepartments();
  }

  Future<List<Lecturer>> getLecturers() async {
//    if (!await offlineMode) {
////      List<Lecturer> lecturers = await _cacheLecturerProvider.getLecturers();
//      List<Lecturer> lecturers = await _inetLecturerProvider.getLecturers();//TODO: DECIDE WHERE INFO SHOULD COME FROM?
//      // await _cacheLecturerProvider.putLecturers(lecturers);
//      return lecturers;
//    }
    return _cacheLecturerProvider.getLecturers();
  }
}
