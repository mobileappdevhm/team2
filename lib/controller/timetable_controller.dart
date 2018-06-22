import 'dart:async';

import 'package:courses_in_english/model/course/custom_course.dart';

abstract class TimetableController {
  void addObserver(TimetableListObserver observer);

  Future<bool> addCustomCourse(CustomCourse course);

  Future<bool> removeCustomCourse(CustomCourse course);

  Future<List<CustomCourse>> get timetable;
}

abstract class TimetableListObserver {
  void onFavoritesUpdated(List<CustomCourse> timetable);
}
