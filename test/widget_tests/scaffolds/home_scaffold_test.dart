import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';
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

    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => Future.value(<Course>[]));

    Content content = new Content();
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold(content)));
  });
}
