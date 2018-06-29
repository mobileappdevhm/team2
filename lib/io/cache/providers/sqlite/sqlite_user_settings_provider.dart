import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SqliteUserSettingsProvider extends CacheUserSettingsProvider {
  final DatabaseHelper dbh;
  SharedPreferences preferences;

  SqliteUserSettingsProvider(this.dbh);

  @override
  Future<UserSettings> getCurrentSettings() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("offlineMode") != null) {
      return new UserSettings(
          offlineMode: preferences.getBool("offlineMode"),
          feedbackMode: preferences.getBool("feedbackMode"));
    } else {
      putSettings(new UserSettings());
      return new UserSettings();
    }
  }

  @override
  void putSettings(UserSettings userSettings) async {
    preferences.setBool("offlineMode", userSettings.offlineMode);
    preferences.setBool("feedbackMode", userSettings.feedbackMode);
  }

  @override
  void clearApp() async {
    dbh.truncateAllTable();
  }
}
