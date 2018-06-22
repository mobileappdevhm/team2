import 'dart:async';

import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/controller/timetable_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/model/course/custom_course.dart';

class NormalTimetableController implements TimetableController {
  List<TimetableListObserver> observers = [];
  CacheSelectedCourseProvider cacheSelectedCourseProvider;
  CacheCustomCourseProvider cacheCustomCourseProvider;
  InetSelectedCourseProvider inetSelectedCourseProvider;

  NormalTimetableController(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory)
      : cacheSelectedCourseProvider =
            cacheProviderFactory.createSelectedCourseProvider(),
        cacheCustomCourseProvider =
            cacheProviderFactory.createCustomCourseProvider(),
        inetSelectedCourseProvider =
            inetProviderFactory.createSelectedCourseProvider();

  void addObserver(TimetableListObserver observer) {
    observers.add(observer);
    timetable.then((timetable) => observer.onFavoritesUpdated(timetable));
  }

  Future<bool> addCustomCourse(CustomCourse course) async {
    bool result = 0 !=
        await cacheCustomCourseProvider.putCourse(
            course, new Injector().sessionController.user);
    timetable.then((timetable) => observers
        .forEach((observer) => observer.onFavoritesUpdated(timetable)));
    return result;
  }

  Future<bool> removeCustomCourse(CustomCourse course) async {
    bool result = await cacheCustomCourseProvider.deleteCourse(
        course, new Injector().sessionController.user);
    timetable.then((timetable) => observers
        .forEach((observer) => observer.onFavoritesUpdated(timetable)));
    return result;
  }

  Future<List<CustomCourse>> get timetable async {
    List<CustomCourse> tempList = (await cacheSelectedCourseProvider
            .getCourses(new Injector().sessionController.user))
        .map((course) => course.toCustomCourse())
        .toList();
    tempList.addAll(await cacheCustomCourseProvider
        .getCourses(new Injector().sessionController.user));
    return new Future(() => tempList);
  }
}
