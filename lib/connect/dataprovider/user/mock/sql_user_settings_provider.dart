import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

class SqliteUserSettingsProvider extends UserSettingsProvider {
  Future<UserSettings> getCurrentSettings() async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> data = await dbh.selectTable("Settings");
    return new UserSettings(
        feedbackMode: data[0]["feedbackMode"].toLowerCase() == 'true',
        offlineMode: data[0]["offlineMode"].toLowerCase() == 'true');
  }

  Future<int> putSettings(UserSettings userSettings) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> userList = [];
    userList.add(userSettings.toMap());
    return dbh.insertTable("Settings", userList);
    //TODO: WHEN USER LOGS IN NEED TO CREATE USER AND SETTINGS
  }
}
