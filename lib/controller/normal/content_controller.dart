import 'dart:async';

import 'package:courses_in_english/controller/content_controller.dart';
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
class NormalContentController implements ContentController {
  InetCourseProvider inetCourseProvider;
  InetLecturerProvider inetLecturerProvider;
  InetDepartmentProvider inetDepartmentProvider;
  InetCampusProvider inetCampusProvider;

  CacheCourseProvider cacheCourseProvider;
  CacheLecturerProvider cacheLecturerProvider;
  CacheDepartmentProvider cacheDepartmentProvider;
  CacheCampusProvider cacheCampusProvider;

  NormalContentController(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory)
      : inetCampusProvider = inetProviderFactory.createCampusProvider(),
        inetCourseProvider = inetProviderFactory.createCourseProvider(),
        inetDepartmentProvider = inetProviderFactory.createDepartmentProvider(),
        inetLecturerProvider = inetProviderFactory.createLecturerProvider(),
        cacheLecturerProvider = cacheProviderFactory.createLecturerProvider(),
        cacheDepartmentProvider =
            cacheProviderFactory.createDepartmentProvider(),
        cacheCourseProvider = cacheProviderFactory.createCourseProvider(),
        cacheCampusProvider = cacheProviderFactory.createCampusProvider();



  /// Get all public content.
  @override
  Future<Content> getContent() async {
    await putFakeData();
    Content content = new Content();
    content.campuses = await getCampuses();
    content.courses = await getCourses();
    content.departments = await getDepartments();
    content.lecturers = await getLecturers();
    return content;
  }

  @override
  Future<List<Course>> getCourses() async {
    if (!await offlineMode) {
      List<Course> courses = await inetCourseProvider.getCourses();
      // await _cacheCourseProvider.putCourses(courses);
      return courses;
    }
    return cacheCourseProvider.getCourses();
  }

  Future<int> putFakeData() async{
    await cacheLecturerProvider.truncate();
    await cacheDepartmentProvider.truncate();
    await cacheCampusProvider.truncate();
    await cacheCourseProvider.truncate();

    int r1 = await cacheLecturerProvider.putLecturers([lecturer01,lecturer02,lecturer03,lecturer04,lecturer05]);
    int r2 = await cacheCampusProvider.putCampuses([campus01,campus02,campus03]);
    int r4 = await cacheDepartmentProvider.putDepartments([department01,department02,department03,department04,department05,department06,department07,department08,department09,department10,department11,department12,department13,department14]);
    int r3 = await cacheCourseProvider.putCourses([course01,course02,course03,course04,course05]);

    return (new Future( () => 0 ));
  }

  @override
  Future<List<Campus>> getCampuses() async {
    if (!await offlineMode) {
      List<Campus> campuses = await inetCampusProvider.getCampuses();
      // await _cacheCampusProvider.putCampuses(campuses);
      return campuses;
    }
    return cacheCampusProvider.getCampuses();
  }

  @override
  Future<List<Department>> getDepartments() async {
    if (!await offlineMode) {
      List<Department> departments =
          await inetDepartmentProvider.getDepartments();
      // await _cacheDepartmentProvider.putDepartments(departments);
      return departments;
    }
    return cacheDepartmentProvider.getDepartments();
  }

  @override
  Future<List<Lecturer>> getLecturers() async {
    if (!await offlineMode) {
      List<Lecturer> lecturers = await inetLecturerProvider.getLecturers();
      // await _cacheLecturerProvider.putLecturers(lecturers);
      return lecturers;
    }
    return cacheLecturerProvider.getLecturers();
  }

  // TODO FIX OFFLINE MODE
  @override
  Future<bool> get offlineMode async => false;
}
