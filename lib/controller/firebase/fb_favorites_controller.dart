import 'dart:async';

import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/firebase/firebase_controller.dart';
import 'package:courses_in_english/model/course/course.dart';

class FbFavoritesController implements FavoritesController {
  final FavoritesController controller;
  final FirebaseController firebaseController;

  FbFavoritesController(this.firebaseController, this.controller);

  @override
  void addObserver(FavoriteListObserver observer) {
    return controller.addObserver(observer);
  }

  @override
  Future<List<Course>> get favorites => controller.favorites;

  @override
  Future<bool> favorizeCourse(Course course) {
    firebaseController.logEvent(name: "favorize_course", value: course.name);
    return controller.favorizeCourse(course);
  }

  @override
  void pushFavorites() {
    firebaseController.logEvent(name: "push_favorites");
    return controller.pushFavorites();
  }

  @override
  Future<bool> unFavorizeCourse(Course course) {
    firebaseController.logEvent(name: "unfavorize_course", value: course.name);
    return controller.unFavorizeCourse(course);
  }
}
