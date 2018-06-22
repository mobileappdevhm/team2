import 'dart:async';

import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';

class NormalFavoritesController implements FavoritesController {
  List<FavoriteListObserver> observers = [];

  final CacheCourseProvider cacheCourseProvider;
  final InetCourseProvider inetCourseProvider;

  NormalFavoritesController(
      CacheProviderFactory cacheFactory, InetProviderFactory inetFactory)
      : cacheCourseProvider = cacheFactory.createCourseProvider(),
        inetCourseProvider = inetFactory.createCourseProvider();

  @override
  void addObserver(FavoriteListObserver observer) {
    observers.add(observer);
    favorites.then((favorites) => observer.onFavoritesUpdated(favorites));
  }

  @override
  Future<bool> favorizeCourse(Course course) async {
    bool result = await cacheCourseProvider.favorizeCourse(course, new Injector().sessionController.user);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    return result;
  }

  @override
  Future<bool> unFavorizeCourse(Course course) async {
    bool result = await cacheCourseProvider.unFavorizeCourse(course, new Injector().sessionController.user);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    return result;
  }

  @override
  void pushFavorites() async {
    // TODO use inetCourseProvider to push favorites to server
  }

  @override
  Future<List<Course>> get favorites async =>
      cacheCourseProvider.getFavorizedCourses(new Injector().sessionController.user);
}
