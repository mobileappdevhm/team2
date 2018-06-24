import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/ui/scaffolds/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {

  MockitoProviderFactory inetFactory;
  MockedCacheProvidersFactory cacheFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    new Injector().injectDependencies(inetFactory, cacheFactory, firebase: false);
  });

  testWidgets('Test information display', (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course01, false), // favorite = false
      ),
    );
    // Search course name
    expect(find.text(course01.name), findsOneWidget);
    // Search course description
    expect(find.text(course01.description), findsOneWidget);
    // Search department number
    expect(
      find.text('Department ${department07.number.toString().padLeft(2, '0')}'),
      findsOneWidget,
    );
    // Search professor name
    expect(find.text(lecturer01.name), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
  testWidgets('Test information display - favorite',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course01, true), // favorite = false
      ),
    );
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
  testWidgets('Test favorize', (WidgetTester tester) async {
    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => Future.value(<Course>[]));
    when(cacheFactory.cacheCourseProvider.favorizeCourse(course01, user)).thenAnswer((_) => Future.value(true));
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course01, false),
      ),
    );
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    verify(cacheFactory.cacheCourseProvider.favorizeCourse(course01, user)).called(1);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
  testWidgets('Test unfavorize', (WidgetTester tester) async {
    Department department = new Department(1, 1, "a", 0);
    User user = new User("benutzername", "vorname", "nachname", department, "token", 42);
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses(user)).thenAnswer((_) => Future.value(<Course>[]));
    when(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01,user)).thenAnswer((_) => Future.value(false));
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course01, true),
      ),
    );
    verifyZeroInteractions(cacheFactory.cacheCourseProvider);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    verify(cacheFactory.cacheCourseProvider.unFavorizeCourse(course01,user)).called(1);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}
