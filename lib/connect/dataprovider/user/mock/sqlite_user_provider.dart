import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Mock user provider.
class SqlUserProvider implements UserProvider {
  @override
  Future<User> login(String username, String password) async {
    print("Trying to log in.");

    return new User(-1, "", "", "", 7);
  }

  @override
  Future<bool> logout(User user) async {
    print("Trying to log out.");

    return true;
  }

  @override
  Future<bool> createUser(String username, String firstName, String lastName,
      int department) async {
    // Todo: create new User with Nine.
    return true;
  }
}
