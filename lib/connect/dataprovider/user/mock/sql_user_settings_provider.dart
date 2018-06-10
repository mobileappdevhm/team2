import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';
import 'dart:async';
import 'package:courses_in_english/model/globals/globals.dart' as globals;

class SqlUserSettingsProvider extends UserSettingsProvider {
  Future<UserSettings> getCurrentSettings() async {
    DatabaseHelper dbh = new DatabaseHelper();
    Map<String, dynamic> data = await dbh.selectOneWhere(
        "Settings", "userId", globals.userId.toString());
    return new UserSettings(globals.userId,
        feedbackMode: data["feedbackMode"].toLowerCase() == 'true',
        offlineMode: data["offlineMode"].toLowerCase() == 'true');
  }

  Future<int> putCurrentSettings(UserSettings userSettings) async {
    DatabaseHelper dbh = new DatabaseHelper();
    return dbh.updateTablebyId(
        "Settings", userSettings.toMap(), "userId", globals.userId.toString());
    //TODO: WHEN USER LOGS IN NEED TO CREATE USER AND SETTINGS
  }

  Future<int> putSettings(UserSettings userSettings) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> userList = [];
    userList.add(userSettings.toMap());
    return dbh.insertTable("Settings", userList);
    //TODO: WHEN USER LOGS IN NEED TO CREATE USER AND SETTINGS
  }
}
