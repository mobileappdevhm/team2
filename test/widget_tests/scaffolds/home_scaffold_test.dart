import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {

  FavoritesController favoritesController = new FavoritesController();
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    favoritesController.injectDependencies(inetFactory, cacheFactory);
  });
  testWidgets('HomeScaffold test', (WidgetTester tester) async {
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => Future.value(<Course>[]));
    Content content = new Content();
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold(content)));
  });

}
