import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/scaffolds/bnb_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';


void main() {
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    new Injector().injectDependencies(inetFactory, cacheFactory, firebase: false);
  });
  testWidgets('Courselist search and filter test', (WidgetTester tester) async {
    when(cacheFactory.cacheCourseProvider.getFavorizedCourses()).thenAnswer((_) => Future.value(<Course>[]));
    Content content = new Content();
    await tester.pumpWidget(new MaterialApp(home: new HomeScaffold(content)));

    // Go to course_list_screen
    await tester.tap(find.byIcon(Icons.import_contacts));
    await tester.tap(find.widgetWithIcon(IconButton, Icons.search));
    tester.enterText(find.byKey(Key("SearchBarTextField")), "app\n");
    
    expect(find.text("Development"), findsOneWidget);
  });


/*  testWidgets('Test Course List Item favorite mechanism',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseListScreen(MOCK_COURSES, FAVS),
      ),
    );

    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border),
        findsNWidgets(MOCK_COURSES.length - 1));
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
  }); */
}
