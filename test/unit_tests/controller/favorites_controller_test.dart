import 'dart:async';

import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  FavoritesController controller = new FavoritesController();
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    controller.injectDependencies(inetFactory, cacheFactory);
  });
  test('Test favorize', () async {
    when(cacheFactory.cacheCourseProvider.favorizeCourse(course01)).thenAnswer((_) => new Future.value(true));
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    await controller.favorizeCourse(course01);
    verify(cacheFactory.cacheCourseProvider.favorizeCourse(course01)).called(1);
  });
  test('Test unfavorize', () async {
    when(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01)).thenAnswer((_) => new Future.value(false));
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    await controller.unFavorizeCourse(course01);
    verify(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01)).called(1);
  });
  test('Test observer notification on registration', () async {
    FavoriteListObserver favoritesScreen = new MockitoFavoritesObserver();
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => new Future.value(<Course>[]));
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    verifyZeroInteractions(favoritesScreen);
    controller.addObserver(favoritesScreen);
    await untilCalled(favoritesScreen.onFavoritesUpdated(<Course>[]));
    verify(cacheFactory.cacheCourseProvider.getFavorizedCourses()).called(1);
    verify(favoritesScreen.onFavoritesUpdated(<Course>[])).called(1);
  });
  test('Test observer notification on favorize', () async {
    FavoriteListObserver favoritesScreen = new MockitoFavoritesObserver();
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => new Future.value(<Course>[]));
    controller.addObserver(favoritesScreen);
    await untilCalled(favoritesScreen.onFavoritesUpdated(<Course>[]));
    reset(cacheFactory.cacheCourseProvider);
    reset(favoritesScreen);
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => new Future.value([course01]));
    when(cacheFactory.cacheCourseProvider.favorizeCourse(course01)).thenAnswer((_) => new Future.value(true));
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    verifyZeroInteractions(favoritesScreen);
    controller.favorizeCourse(course01);
    await untilCalled(favoritesScreen.onFavoritesUpdated([course01]));
    verify(cacheFactory.cacheCourseProvider.getFavorizedCourses()).called(1);
    verify(favoritesScreen.onFavoritesUpdated([course01])).called(1);
  });
}
class MockitoFavoritesObserver extends Mock implements FavoriteListObserver {}