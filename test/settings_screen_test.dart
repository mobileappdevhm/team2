//import 'package:courses_in_english/connect/dataprovider/data.dart';
//import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';



void main() {
  testWidgets('notLoggedInTest', (WidgetTester tester) async {
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
    expect(_data.getCurrentSettings().autoSync, false);
    await tester.tap(find.byType(Switch).first);
    expect(_data.getCurrentSettings().autoSync, true);
  });

  testWidgets('OfflineModeTest', (WidgetTester tester) async {
    UserSettingsProvider _data = new Data().settingsProvider;
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
    expect(_data.getCurrentSettings().offlineMode, false);
    await tester.tap(find.byType(Switch).at(1));
    expect(_data.getCurrentSettings().offlineMode, true);
  });

//  testWidgets('AutoSyncTest', (WidgetTester tester) async {
//
//    await tester.pumpWidget(
//        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
//    UserSettingsProvider _data = new Data().settingsProvider;
//    UserSettings us = await _data.getCurrentSettings();
//    expect(us.offlineMode, true);
//    expect(us.feedbackMode, false);
//    expect(find.text("General Settings"), findsOneWidget);
//
//    expect(find.text("Guest Users can't save settings"), findsOneWidget);
//    expect(find.byType(LineSeparator), findsOneWidget);
//  });
//
//  testWidgets('OfflineModeTest', (WidgetTester tester) async {
//    UserSettingsProvider _data = new Data().settingsProvider;
//    await tester.pumpWidget(
//        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
//    expect(_data.getCurrentSettings().offlineMode, false);
//    await tester.tap(find.byType(Switch).at(1));
//    expect(_data.getCurrentSettings().offlineMode, true);
//  });

//  testWidgets('feedbackModeModeTest', (WidgetTester tester) async {
//    UserSettingsProvider _data = new Data().settingsProvider;
//    await tester.pumpWidget(
//        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
//    expect(_data.getCurrentSettings().feedbackMode, false);
//    await tester.tap(find.byType(Switch).at(2));
//    expect(_data.getCurrentSettings().feedbackMode, true);
//  });

//
//  testWidgets('otherSettingsTest', (WidgetTester tester) async {
//    UserSettingsProvider _data = new Data().settingsProvider;
//    await tester.pumpWidget(
//        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
//    expect(find.widgetWithText(TextFormField, "Sync Favorites"),
//      findsOneWidget);
//    expect(find.widgetWithText(TextFormField, "Push Favorites"),
//      findsOneWidget);
//    expect(find.widgetWithText(TextFormField, "Sync Options"),
//      findsOneWidget);
//  });

}
