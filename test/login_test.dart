import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";

String email = "Bob@der.Baumeister";
String password = "jowirschaffendas";

void main() {
  testWidgets("testLoginLayout", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(RoundedButton), findsNWidgets(2));
    expect(find.byType(FlatButton), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(SceneryWidget), findsOneWidget);
    expect(find.byType(LineSeparator), findsNWidgets(2));
  });

  /*testWidgets("testLogin", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.emailFieldKey), email);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.enterText(find.byKey(LoginScreen.passwordFieldKey), password);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 500)); // schedule animation
    expect(find.text(LoginScreen.loginSuccess), findsOneWidget);
  });*/

  testWidgets("testLoginNoEmailNoPassword", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.tap(find.byKey(LoginScreen.keyLoginButton));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noEmailAndNoPasswordSnack), findsOneWidget);
  });

  testWidgets("testLoginNoEmail", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.keyPasswordField), password);
    await tester.tap(find.byKey(LoginScreen.keyLoginButton));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noEmailSnack), findsOneWidget);
  });

  /*estWidgets("testLoginNoPassword", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.keyEmailField), email);
    await tester.tap(find.byKey(LoginScreen.keyLoginButton));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noPasswordSnack), findsOneWidget);
  });

  testWidgets("testLoginNoAT", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.keyEmailField), email.replaceAll("@", ""));
    await tester.enterText(find.byKey(LoginScreen.keyPasswordField), password);
    await tester.tap(find.byKey(LoginScreen.keyLoginButton));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.emailWrongFormatSnack), findsOneWidget);
  });

  testWidgets("testLoginNoDot", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.keyEmailField), email.replaceAll(".", ""));
    await tester.enterText(find.byKey(LoginScreen.keyPasswordField), password);
    await tester.tap(find.byKey(LoginScreen.keyLoginButton));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.emailWrongFormatSnack), findsOneWidget);
  });

  testWidgets("testGuest", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.tap(find.byKey(LoginScreen.keyGuestButton));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(LoginScreen.continueAsGuestSnack), findsOneWidget);
  });*/
}
