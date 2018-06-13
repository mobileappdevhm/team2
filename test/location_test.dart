import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const locations = [campus01, campus03];

void main() {
  testWidgets('Test location screen', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new Scaffold(
        body: new LocationScreen(locations),
      ),
    ));
  });
  /* TODO locationsdetailsscreen does some stuff with futures
  testWidgets('Test location details page', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new LocationDetailScreen(campus01.id),
    ));
    await tester.idle();
  });*/
}
