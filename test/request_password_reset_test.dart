import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:courses_in_english/ui/scaffolds/password_reset.dart';
import 'package:courses_in_english/ui/scaffolds/request_password_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("RequestPasswordResetLayoutTest", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    expect(
        find.widgetWithText(
            RoundedButton, RequestPasswordReset.requestResetText),
        findsOneWidget);
    expect(
        find.widgetWithText(FlatButton, RequestPasswordReset.skipRequestText),
        findsOneWidget);
    expect(
        find.text(
            "A reset Code will be sent to the E-Mail address entered below."),
        findsOneWidget);
  });

  testWidgets("EmailWrongFormatRequestTest", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump(new Duration(seconds: 1000));
    expect(find.widgetWithText(SnackBar, RequestPasswordReset.wrongFormatSnack),
        findsOneWidget);
    await tester.pump(new Duration(seconds: 2000));
    await tester.enterText(find.byType(TextField).first, "blabla");
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump(new Duration(seconds: 1000));
    expect(find.widgetWithText(SnackBar, RequestPasswordReset.wrongFormatSnack),
        findsOneWidget);
    await tester.pump(new Duration(seconds: 2000));
    await tester.enterText(find.byType(TextField).first, "blabla@hm");
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump(new Duration(seconds: 1000));
    expect(find.widgetWithText(SnackBar, RequestPasswordReset.wrongFormatSnack),
        findsOneWidget);
    await tester.pump(new Duration(seconds: 2000));
    await tester.enterText(find.byType(TextField).first, "blabla.hm");
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump(new Duration(seconds: 1000));
    expect(find.widgetWithText(SnackBar, RequestPasswordReset.wrongFormatSnack),
        findsOneWidget);
  });

  testWidgets("RequestCode", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.enterText(find.byType(TextField).first, "abc@hm.edu");
    await tester.pump();
    expect(find.widgetWithText(TextField, "abc@hm.edu"), findsOneWidget);
    await tester.tap(find.byType(RoundedButton).first);
    await tester.pump();
    expect(
        find.widgetWithText(AlertDialog, RequestPasswordReset.alertDialogText),
        findsOneWidget);
  });

  testWidgets("SkipRequestCode", (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: new RequestPasswordReset()));
    await tester.tap(find.byType(FlatButton).first);
    await tester.pump();
    expect(find.byType(PasswordReset), findsOneWidget);
  });
}
