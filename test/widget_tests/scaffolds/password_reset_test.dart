import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/scaffolds/password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  MockitoProviderFactory inetFactory;
  MockedCacheProvidersFactory cacheFactory;
  setUp(() {
    inetFactory = new MockitoProviderFactory();
    cacheFactory = new MockedCacheProvidersFactory();
    new Injector()
        .injectDependencies(inetFactory, cacheFactory, firebase: false);
  });

  testWidgets("Test Password Reset Layout",(WidgetTester tester) async{
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset("abc1@hm.edu")));
    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.widgetWithText(RoundedButton, "Reset Password"), findsOneWidget);
  });

  testWidgets("Test Password Reset",
          (WidgetTester tester) async {
        when(inetFactory.userProvider.resetPassword('abc1@hm.edu','code','newPW'))
            .thenAnswer((_) => Future.value(true));
        await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
        await tester.enterText(find.byType(TextFormField).at(1), 'code');
        await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
        await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
        verifyZeroInteractions(inetFactory.userProvider);
        await tester.tap(find.byType(RoundedButton).first);
        await tester.pump();
        verify(inetFactory.userProvider.resetPassword('abc1@hm.edu','code','newPW')).called(1);
        expect(find.widgetWithText(AlertDialog, "Password Successfully changed!"), findsOneWidget);
        expect(find.widgetWithText(FlatButton, "Return to Login Page"), findsOneWidget);
      });

  testWidgets("Test Password Reset - Error",
          (WidgetTester tester) async {
        when(inetFactory.userProvider.resetPassword('abc1@hm.edu','code','newPW'))
            .thenAnswer((_) => Future.value(false));
        await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
        await tester.enterText(find.byType(TextFormField).at(1), 'code');
        await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
        await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
        verifyZeroInteractions(inetFactory.userProvider);
        await tester.tap(find.byType(RoundedButton).first);
        await tester.pump();
        verify(inetFactory.userProvider.resetPassword('abc1@hm.edu','code','newPW')).called(1);
        expect(find.widgetWithText(AlertDialog, "There was an Error changing the Password"), findsOneWidget);
        expect(find.widgetWithText(FlatButton, "Close"), findsOneWidget);
      });

  testWidgets("Test Password Reset Invalid Input - no Email", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), '');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Please fill all Input Fields"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - no Email", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), '');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Please fill all Input Fields"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - no Email", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
    await tester.enterText(find.byType(TextFormField).at(3), '');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Please fill all Input Fields"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - email no @", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Please enter data in a valid format"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - email no .", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1hm@edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Please enter data in a valid format"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - passwords don't match", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW2');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Passwords must match!"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - passwords don't match 2", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'newPW2');
    await tester.enterText(find.byType(TextFormField).at(3), 'newPW');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Passwords must match!"), findsOneWidget);
  });

  testWidgets("Test Password Reset Invalid Input - password to short", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new PasswordReset('abc1@hm.edu')));
    await tester.enterText(find.byType(TextFormField).at(1), 'code');
    await tester.enterText(find.byType(TextFormField).at(2), 'new');
    await tester.enterText(find.byType(TextFormField).at(3), 'new');
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, "Password is to Short (min. 5)"), findsOneWidget);
  });

}