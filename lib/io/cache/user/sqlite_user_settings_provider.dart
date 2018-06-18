import 'dart:async';

import 'package:courses_in_english/io/cache/databasehelper.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';
import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class SqliteUserSettingsProvider extends UserSettingsProvider {
  Future<UserSettings> getCurrentSettings() async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> data =
        await dbh.selectWhere("Settings", "userId", new Session().user.id.toString());
    if (data.isNotEmpty) {
      return new UserSettings(
          feedbackMode: data[0]["feedbackMode"].toLowerCase() == 'true',
          offlineMode: data[0]["offlineMode"].toLowerCase() == 'true');
    } else {
      UserSettings userSettings = new UserSettings();
      putSettings(userSettings);
      return userSettings;
    }
  }

  Future<int> putSettings(UserSettings userSettings) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> userList = [];
    userList
        .add(userSettings.toMap().putIfAbsent("userId", () => new Session().user.id));
    return dbh.insertTable("Settings", userList);
    //TODO: WHEN USER LOGS IN NEED TO CREATE USER AND SETTINGS
  }
}
