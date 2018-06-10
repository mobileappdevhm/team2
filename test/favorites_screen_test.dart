import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const favs = [course01, course03];

void main() {
  testWidgets('Test favorites screen', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new FavoriteListScreen(favs),
      ),
    ));
    expect(find.byType(CourseListEntry), findsNWidgets(2));
  });
}
