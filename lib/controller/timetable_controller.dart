import 'dart:async';

import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/model/course/custom_course.dart';

class TimetableController {
  static final TimetableController _instance = TimetableController._internal();
  TimetableController._internal();
  factory TimetableController() => _instance;

  List<TimetableListObserver> observers = [];
  CacheSelectedCourseProvider _cacheSelectedCourseProvider;
  CacheCustomCourseProvider _cacheCustomCourseProvider;
  InetSelectedCourseProvider _inetSelectedCourseProvider;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory) {
    _cacheSelectedCourseProvider =
        cacheProviderFactory.createSelectedCourseProvider();
    _cacheCustomCourseProvider =
        cacheProviderFactory.createCustomCourseProvider();
    _inetSelectedCourseProvider =
        inetProviderFactory.createSelectedCourseProvider();
  }

  void addObserver(TimetableListObserver observer) {
    observers.add(observer);
    timetable.then((timetable) => observer.onFavoritesUpdated(timetable));
  }

  Future<bool> addCustomCourse(CustomCourse course) async {
    bool result = 0 != await _cacheCustomCourseProvider.putCourse(course);
    timetable.then((timetable) => observers
        .forEach((observer) => observer.onFavoritesUpdated(timetable)));
    return result;
  }

  Future<bool> removeCustomCourse(CustomCourse course) async {
    bool result = await _cacheCustomCourseProvider.deleteCourse(course);
    timetable.then((timetable) => observers
        .forEach((observer) => observer.onFavoritesUpdated(timetable)));
    return result;
  }

  Future<List<CustomCourse>> get timetable async {
    List<CustomCourse> tempList =
        (await _cacheSelectedCourseProvider.getCourses())
            .map((course) => course.toCustomCourse())
            .toList();
    tempList.addAll(await _cacheCustomCourseProvider.getCourses());
    return new Future(() => tempList);
  }
}

abstract class TimetableListObserver {
  void onFavoritesUpdated(List<CustomCourse> timetable);
}
