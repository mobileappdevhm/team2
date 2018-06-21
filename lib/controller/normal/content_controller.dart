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
