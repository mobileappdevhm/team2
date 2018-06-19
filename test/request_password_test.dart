import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/scaffolds/password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("TestRequestPasswordLayout", (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new PasswordReset("bob@der.baumeister")));
    expect(
        find.widgetWithText(TextField, "bob@der.baumeister"), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4));
    expect(
        find.widgetWithText(RoundedButton, PasswordReset.resetPasswordButton),
        findsOneWidget);
  });

  testWidgets("TestPasswordsDontMatch", (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new PasswordReset("bob@der.baumeister")));
    await tester.enterText(find.byType(TextField).at(2), "abc");
    await tester.enterText(find.byType(TextField).at(3), "cba");
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(find.widgetWithText(SnackBar, PasswordReset.passwordsNoMatchSnack),
        findsOneWidget);
  });

  //TODO make tests for success and failure of resetting the passowrd. working Session needed.
}
