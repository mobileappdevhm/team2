import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:mockito/mockito.dart';

void main() {
  MockitoProviderFactory inetFactory;
  MockedCacheProvidersFactory cacheFactory;
  setUp(() {
    inetFactory = new MockitoProviderFactory();
    cacheFactory = new MockedCacheProvidersFactory();
    new Injector()
        .injectDependencies(inetFactory, cacheFactory, firebase: false);
  });
  testWidgets("Test layout", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(SceneryWidget), findsOneWidget);
    expect(find.byType(LineSeparator), findsNWidgets(2));
  });

  testWidgets("Test login", (WidgetTester tester) async {
    when(inetFactory.userProvider.login('test@hm.edu', '12345678'))
        .thenAnswer((_) => Future.value(user));
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), 'test@hm.edu');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '12345678');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump(new Duration(seconds:1));
    await tester.pump();
    verify(inetFactory.userProvider.login('test@hm.edu', '12345678')).called(1);
  });

  testWidgets("Test invalid data - no username", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), '');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '12345678');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });

  testWidgets("Test invalid data - no password", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), 'test@hm.edu');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });

  testWidgets("Test invalid data - no data", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), '');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });

  testWidgets("Test invalid data - invalid email 1: test@hm",
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), 'test@hm');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '12345678');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });

  testWidgets("Test invalid data - invalid email 2: test.hm",
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), 'test.hm');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '12345678');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });

  testWidgets("Test invalid data - invalid email 3: testhm",
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Username'), 'testhm');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Input Password'), '12345678');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.text('Login'));
    await tester.pump();
    verifyZeroInteractions(inetFactory.userProvider);
  });
}
