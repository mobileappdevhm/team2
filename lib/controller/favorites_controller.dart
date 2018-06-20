import 'dart:async';

import 'package:courses_in_english/controller/firebase_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/model/course/course.dart';
//import 'package:courses_in_english/io/inet/providers/course_provider.dart';

class FavoritesController {
  static final FavoritesController _instance = FavoritesController._internal();

  FavoritesController._internal();

  factory FavoritesController() => _instance;

  List<FavoriteListObserver> observers = [];
  CacheCourseProvider _cacheCourseProvider;

  //InetCourseProvider _inetCourseProvider;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory) {
    _cacheCourseProvider = cacheProviderFactory.createCourseProvider();
    //_inetCourseProvider = inetProviderFactory.createCourseProvider();
  }

  void addObserver(FavoriteListObserver observer) {
    observers.add(observer);
    favorites.then((favorites) => observer.onFavoritesUpdated(favorites));
  }

  Future<bool> favorizeCourse(Course course) async {
    bool result = await _cacheCourseProvider.favorizeCourse(course);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    new FirebaseController()
        .logEvent(name: "favorize_course", value: course.name);
    String ammount;
    favorites.then((List<Course> value) {
      ammount = value.length.toString();
    });
    new FirebaseController().logUserParameter(name: "favorites", value: ammount);
    return result;
  }

  Future<bool> unFavorizeCourse(Course course) async {
    bool result = await _cacheCourseProvider.unFavorizeCourse(course);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    new FirebaseController()
        .logEvent(name: "unfavorize_course", value: course.name);
    String ammount;
    favorites.then((List<Course> value) {
      ammount = value.length.toString();
    });
    new FirebaseController().logUserParameter(name: "favorites", value: ammount);
    return result;
  }

  void pushFavorites() async {
    // TODO use inetCourseProvider to push favorites to server
    new FirebaseController().logEvent(name: "push_favorites");
  }

  Future<List<Course>> get favorites async =>
      _cacheCourseProvider.getFavorizedCourses();
}

abstract class FavoriteListObserver {
  void onFavoritesUpdated(List<Course> favorites);
}
