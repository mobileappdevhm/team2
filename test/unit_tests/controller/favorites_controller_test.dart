import 'dart:async';

import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/normal/favorites_controller.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  FavoritesController controller;
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    controller = new NormalFavoritesController(cacheFactory, inetFactory);
  });
  test('Test favorize', () async {

    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.favorizeCourse(course01,user)).thenAnswer((_) => new Future.value(true));

    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    await controller.favorizeCourse(course01);
    verify(cacheFactory.cacheCourseProvider.favorizeCourse(course01,user)).called(1);
  });
  test('Test unfavorize', () async {

    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01,user)).thenAnswer((_) => new Future.value(false));
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    await controller.unFavorizeCourse(course01);
    verify(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01,user)).called(1);
  });
  test('Test observer notification on registration', () async {
    FavoriteListObserver favoritesScreen = new MockitoFavoritesObserver();
    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => new Future.value(<Course>[]));

    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    verifyZeroInteractions(favoritesScreen);
    controller.addObserver(favoritesScreen);
    await untilCalled(favoritesScreen.onFavoritesUpdated(<Course>[]));
    verify(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).called(1);
    verify(favoritesScreen.onFavoritesUpdated(<Course>[])).called(1);
  });
  test('Test observer notification on favorize', () async {
    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    FavoriteListObserver favoritesScreen = new MockitoFavoritesObserver();

    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => new Future.value(<Course>[]));

    controller.addObserver(favoritesScreen);
    await untilCalled(favoritesScreen.onFavoritesUpdated(<Course>[]));
    reset(cacheFactory.cacheCourseProvider);
    reset(favoritesScreen);

    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => new Future.value([course01]));
    when(cacheFactory.cacheCourseProvider.favorizeCourse(course01,user)).thenAnswer((_) => new Future.value(true));

    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    verifyZeroInteractions(favoritesScreen);
    controller.favorizeCourse(course01);
    await untilCalled(favoritesScreen.onFavoritesUpdated([course01]));
    verify(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).called(1);
    verify(favoritesScreen.onFavoritesUpdated([course01])).called(1);
  });
}

class MockitoFavoritesObserver extends Mock implements FavoriteListObserver {}
