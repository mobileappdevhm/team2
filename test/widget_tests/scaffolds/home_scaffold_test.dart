import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    new Injector()
        .injectDependencies(inetFactory, cacheFactory, firebase: false);
  });
  testWidgets('HomeScaffold test', (WidgetTester tester) async {

    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => Future.value(<Course>[]));

    Content content = new Content();
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold(content)));
  });
}
