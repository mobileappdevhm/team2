import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/scaffolds/password_reset.dart';
import 'package:courses_in_english/ui/scaffolds/request_password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    expect(find.widgetWithText(RoundedButton, "Request Reset Code"),
        findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(
        find.widgetWithText(
            FlatButton, "Already have a Reset-Code? Click here!"),
        findsOneWidget);
    expect(
        find.text(
            "A reset Code will be sent to the E-Mail address entered below."),
        findsOneWidget);
  });

  testWidgets("Test Request of Code - Known EMail",
      (WidgetTester tester) async {
    when(inetFactory.userProvider.requestResetCode('abc1@hm.edu'))
        .thenAnswer((_) => Future.value(true));
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1@hm.edu');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    verify(inetFactory.userProvider.requestResetCode('abc1@hm.edu')).called(1);
    expect(
        find.widgetWithText(
            AlertDialog, "Check your Inbox & Spam for our Mail."),
        findsOneWidget);
    expect(find.widgetWithText(FlatButton, "Continue"), findsOneWidget);
  });

  testWidgets("Test Request of Code - Unknown Email",
      (WidgetTester tester) async {
    when(inetFactory.userProvider.requestResetCode('abc1@hm.edu'))
        .thenAnswer((_) => Future.value(false));
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1@hm.edu');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    verify(inetFactory.userProvider.requestResetCode('abc1@hm.edu')).called(1);
    expect(
        find.widgetWithText(
            AlertDialog,
            "The E-Mail you entered is not known to the Server.\r\n"
            "Please Check the E-Mail for typos and try again."),
        findsOneWidget);
    expect(find.widgetWithText(FlatButton, "Close"), findsOneWidget);
  });

  testWidgets("Test Skip Request of Code", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1@hm.edu');
    await tester.tap(find.byType(FlatButton).first);
    expect(find.byType(PasswordReset), findsNothing);
    await tester.pump();
    expect(find.byType(PasswordReset), findsOneWidget);
  });

  testWidgets("Test Wrong Input - no @", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1hm.edu');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(
        find.widgetWithText(
            SnackBar, "Please Enter a Valid E-Mail in the Format: abc@d.e"),
        findsOneWidget);
  });

  testWidgets("Test Wrong Input - no .", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1hm@edu');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(
        find.widgetWithText(
            SnackBar, "Please Enter a Valid E-Mail in the Format: abc@d.e"),
        findsOneWidget);
  });

  testWidgets("Test Wrong Input - no @ & no .", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, 'abc1hmedu');
    verifyZeroInteractions(inetFactory.userProvider);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(
        find.widgetWithText(
            SnackBar, "Please Enter a Valid E-Mail in the Format: abc@d.e"),
        findsOneWidget);
  });
}
