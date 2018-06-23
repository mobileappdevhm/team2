import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
//import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
//import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/model/user/user_settings.dart';
import 'package:courses_in_english/model/user/user.dart';
//import 'package:courses_in_english/controller/session_controller.dart';


class SqliteUserProvider extends CacheUserProvider {
  final DatabaseHelper dbh;

  SqliteUserProvider(this.dbh);

  @override
  Future<User> login(User userProfile) async {
    List<Map<String, dynamic>> userList = await dbh.selectWhere(
        "User", "username", userProfile.username);
    if (userList.length != 0) {
      return new User(userList[0]["username"], userList[0]["firstName"],
          userList[0]["lastName"], userList[0]["department"],
          userList[0]["token"]);
    }
    User user = new User(userProfile.firstName,
        userProfile.lastName,
        userProfile.username,
        userProfile.department,
        userProfile.token);

    await dbh.insertOneTable("User", user.toMap());
    UserSettings userSettings = new UserSettings();
    await dbh.insertOneTable("Settings", userSettings.toMap().putIfAbsent(
        "userId", () => userProfile.id));

    return new Future(() => user);
  }


  @override
  Future<bool> logout(User user) {
    return new Future( () => false);
  }
}
