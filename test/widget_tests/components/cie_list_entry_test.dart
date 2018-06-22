import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/ui/basic_components/cie_list_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cie list entry skeleton', (WidgetTester tester) async {
    Cie cie = new Cie('name', 7, 'lecturer', 5.0) ;
      await tester.pumpWidget(new MaterialApp(
        home: new Scaffold(
          body: new CieListEntry(cie, null),
        ),
      ));
    });
}