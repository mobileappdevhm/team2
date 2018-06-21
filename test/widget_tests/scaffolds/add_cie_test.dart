import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/ui/scaffolds/add_cie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  CieController controller = new CieController();
  MockedCacheProvidersFactory factory;

  setUp(() {
    factory = new MockedCacheProvidersFactory();
    controller.injectDependencies(factory);
    controller.user = null;
  });

  testWidgets('testTest', (WidgetTester tester) async {
    Cie cie = new Cie('name', 7, 'lecturer', 5.0, null);
    when(factory.cacheCieProvider.putCie(cie, null)).thenAnswer((_) => Future.value(0));
    await tester.pumpWidget(new MaterialApp(
      home: new AddCieScaffold(),
    ));
    verifyZeroInteractions(factory.cacheCieProvider);
    await tester.enterText(find.widgetWithText(TextFormField, 'Input Name'), 'name');
    await tester.enterText(find.widgetWithText(TextFormField, 'Input Lecturer Name'), 'lecturer');
    await tester.enterText(find.widgetWithText(TextFormField, 'Input Ects (Decimal)'), '5.0');
    await tester.enterText(find.widgetWithText(TextFormField, 'Input Department (Integer)'), '7');
    verifyZeroInteractions(factory.cacheCieProvider);
    await tester.tap(find.text('Add'));
    verify(factory.cacheCieProvider.putCie(cie, null)).called(1);
  });

}
