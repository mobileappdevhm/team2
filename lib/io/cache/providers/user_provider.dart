import 'dart:async';

import 'package:courses_in_english/model/user/user.dart';

/// Provider for users.
abstract class CacheUserProvider {
  /// Trys to login the User using his cached token.
  Future<User> login(String token);

  /// Try to log out a user. Returns whether the user could be logged out.
  Future<bool> logout(String token);

  /// If a new user needs to be inserted, we use this method.
  void save(User user);
}
