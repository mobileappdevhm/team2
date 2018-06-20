import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/scenery_widget.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";

String email = "Bob@der.Baumeister";
String password = "jowirschaffendas";

void main() {
  testWidgets("testLoginLayout", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    expect(find.byType(RaisedButton), findsNWidgets(2));
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(SceneryWidget), findsOneWidget);
    expect(find.byType(LineSeparator), findsOneWidget);
  });

  /*testWidgets("testLogin", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.emailFieldKey), email);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.enterText(find.byKey(LoginScreen.passwordFieldKey), password);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 500)); // schedule animation
    expect(find.text(LoginScreen.loginSuccess), findsOneWidget);
  });

  testWidgets("testLoginNoEmailNoPassword", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noEmailAndNoPassword), findsOneWidget);
  });

  testWidgets("testLoginNoEmail", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.passwordFieldKey), password);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noEmail), findsOneWidget);
  });

  testWidgets("testLoginNoPassword", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.emailFieldKey), email);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.noPassword), findsOneWidget);
  }); */

  /*testWidgets("testLoginNoAT", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.emailFieldKey), email.replaceAll("@", ""));
    await tester.enterText(find.byKey(LoginScreen.passwordFieldKey), password);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.emailWrongFormat), findsOneWidget);
  });*/

  /*testWidgets("testLoginNoDot", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.enterText(find.byKey(LoginScreen.emailFieldKey), email.replaceAll(".", ""));
    await tester.enterText(find.byKey(LoginScreen.passwordFieldKey), password);
    await tester.tap(find.byKey(LoginScreen.loginButtonKey));
    await tester.pump(const Duration(milliseconds: 1000)); // schedule animation
    expect(find.text(LoginScreen.emailWrongFormat), findsOneWidget);
  });*/

  /*testWidgets("testGuest", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new LoginScreen()));
    await tester.tap(find.byKey(LoginScreen.guestButtonKey));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(LoginScreen.continueAsGuest), findsOneWidget);
  });*/
}
