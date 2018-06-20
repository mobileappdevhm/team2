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
  FirebaseController _firebaseController;

  //InetCourseProvider _inetCourseProvider;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory, [FirebaseController firebase]) {
    _cacheCourseProvider = cacheProviderFactory.createCourseProvider();
    //_inetCourseProvider = inetProviderFactory.createCourseProvider();
    if (firebase != null) {
      _firebaseController = firebase;
    }
  }

  void addObserver(FavoriteListObserver observer) {
    observers.add(observer);
    favorites.then((favorites) => observer.onFavoritesUpdated(favorites));
  }

  Future<bool> favorizeCourse(Course course) async {
    bool result = await _cacheCourseProvider.favorizeCourse(course);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    _firebaseController?.logEvent(name: "favorize_course", value: course.name);
    favorites.then((List<Course> value) {
      if (value != null) {
        String ammount = value.length.toString();
        _firebaseController?.logUserParameter(name: "favorites", value: ammount);
      }
    });
    return result;
  }

  Future<bool> unFavorizeCourse(Course course) async {
    bool result = await _cacheCourseProvider.unFavorizeCourse(course);
    favorites.then((favorites) => observers
        .forEach((observer) => observer.onFavoritesUpdated(favorites)));
    _firebaseController?.logEvent(name: "unfavorize_course", value: course.name);
    String ammount;
    favorites.then((List<Course> value) {
      if (value != null) {
        String ammount = value.length.toString();
        _firebaseController?.logUserParameter(name: "favorites", value: ammount);
      }
    });
    _firebaseController?.logUserParameter(name: "favorites", value: ammount);
    return result;
  }

  void pushFavorites() async {
    // TODO use inetCourseProvider to push favorites to server
    _firebaseController.logEvent(name: "push_favorites");
  }

  Future<List<Course>> get favorites async =>
      _cacheCourseProvider.getFavorizedCourses();
}

abstract class FavoriteListObserver {
  void onFavoritesUpdated(List<Course> favorites);
}
