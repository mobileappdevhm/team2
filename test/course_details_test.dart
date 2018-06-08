import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/ui/scaffolds/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final course = course01;
final department = department07;
final lecturer = lecturer01;

void main() {
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
  testWidgets('Test information display - favorite', (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course01, true), // favorite = false
      ),
    );
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
  /*testWidgets('Test favorite mechaninism', (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseDetailsScaffold(course, false),
      ),
    );

    // TODO rewrite providers to use mockito
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });*/

}
