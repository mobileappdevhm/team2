import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AutoSyncTest', (WidgetTester tester) async {
    UserSettingsProvider _data = new Data().settingsProvider;
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

  testWidgets('AltLayoutTest', (WidgetTester tester) async {
    UserSettingsProvider _data = new Data().settingsProvider;
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
    expect(_data.getCurrentSettings().usesDrawer, false);
    await tester.tap(find.byType(Switch).at(2));
    expect(_data.getCurrentSettings().usesDrawer, true);
  });

  testWidgets('SecretSettingTest', (WidgetTester tester) async {
    UserSettingsProvider _data = new Data().settingsProvider;
    await tester.pumpWidget(
        new MaterialApp(home: new Scaffold(body: new SettingsScreen())));
    expect(_data.getCurrentSettings().secret1, true);
    await tester.tap(find.byType(Switch).at(3));
    expect(_data.getCurrentSettings().secret1, false);
  });
}
