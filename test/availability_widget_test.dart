import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/availability_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test RED', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new AvailabilityWidget(CourseStatus.RED),
      ),
    ));
    expect(find.byIcon(Icons.cancel), findsOneWidget);
    expect(find.byIcon(Icons.remove_circle), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsNothing);
    expect(find.text('Only \'Home\''), findsOneWidget);
    expect(find.text('Limited'), findsNothing);
    expect(find.text('Available'), findsNothing);
  });
  testWidgets('Test YELLOW', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new AvailabilityWidget(CourseStatus.YELLOW),
      ),
    ));
    expect(find.byIcon(Icons.cancel), findsNothing);
    expect(find.byIcon(Icons.remove_circle), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsNothing);
    expect(find.text('Only \'Home\''), findsNothing);
    expect(find.text('Limited'), findsOneWidget);
    expect(find.text('Available'), findsNothing);
  });
  testWidgets('Test GREEN', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new AvailabilityWidget(CourseStatus.GREEN),
      ),
    ));
    expect(find.byIcon(Icons.cancel), findsNothing);
    expect(find.byIcon(Icons.remove_circle), findsNothing);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.text('Only \'Home\''), findsNothing);
    expect(find.text('Limited'), findsNothing);
    expect(find.text('Available'), findsOneWidget);
  });
}