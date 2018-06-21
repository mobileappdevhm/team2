import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';
//import 'package:courses_in_english/io/inet/providers/course_provider.dart';

abstract class FavoritesController {
  void addObserver(FavoriteListObserver observer);

  Future<bool> favorizeCourse(Course course);

  Future<bool> unFavorizeCourse(Course course);

  void pushFavorites();

  Future<List<Course>> get favorites;
}

abstract class FavoriteListObserver {
  void onFavoritesUpdated(List<Course> favorites);
}
