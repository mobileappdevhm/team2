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

/// Controller for accessing and caching information which is available to both
/// guests and registered users.
class ContentController {
  // Singleton
  static final _instance = new ContentController._internal();
  factory ContentController() => _instance;
  ContentController._internal();

  // TODO implement offline mode
  Future<bool> get offlineMode async => false;

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

  /// Get all public content.
  Future<Content> getContent() async {
    Content content = new Content();
    content.campuses = await getCampuses();
    content.courses = await getCourses();
    content.departments = await getDepartments();
    content.lecturers = await getLecturers();
    return content;
  }

  Future<List<Course>> getCourses() async {
    if (!await offlineMode) {
      List<Course> courses = await _inetCourseProvider.getCourses();
      // await _cacheCourseProvider.putCourses(courses);
      return courses;
    }
    return _cacheCourseProvider.getCourses();
  }

  Future<List<Campus>> getCampuses() async {
    if (!await offlineMode) {
      List<Campus> campuses = await _inetCampusProvider.getCampuses();
      // await _cacheCampusProvider.putCampuses(campuses);
      return campuses;
    }
    return _cacheCampusProvider.getCampuses();
  }

  Future<List<Department>> getDepartments() async {
    if (!await offlineMode) {
      List<Department> departments =
          await _inetDepartmentProvider.getDepartments();
      // await _cacheDepartmentProvider.putDepartments(departments);
      return departments;
    }
    return _cacheDepartmentProvider.getDepartments();
  }

  Future<List<Lecturer>> getLecturers() async {
    if (!await offlineMode) {
      List<Lecturer> lecturers = await _inetLecturerProvider.getLecturers();
      // await _cacheLecturerProvider.putLecturers(lecturers);
      return lecturers;
    }
    return _cacheLecturerProvider.getLecturers();
  }
}
