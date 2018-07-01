import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class SqliteUserProvider extends CacheUserProvider {
  final DatabaseHelper dbh;

  SqliteUserProvider(this.dbh);

  @override
  Future<User> login(String token) async {
    Map<String, dynamic> userList =
        await dbh.selectOneWhere("User", "token", token);
    return new User(userList["username"], userList["firstName"],
        userList["lastName"], null, userList["token"]);
  }

  @override
  Future<bool> logout(String token) async {
    await dbh.deleteWhere("User", "token", token);
    await dbh.truncateUserData();
    return false;
  }

  @override
  void save(User userProfile) async {
    User user = new User(userProfile.firstName, userProfile.lastName,
        userProfile.username, userProfile.department, userProfile.token);

    await dbh.insertOneTable("User", user.toMap());
  }
}
