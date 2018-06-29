import 'dart:async';

import 'package:courses_in_english/model/user/user.dart';

/// Provider for users.
abstract class InetUserProvider {
  /// Try to log in a user. In case the credentials are invalid it returns null.
  /// In case the user could be logged in successfully, it returns the user object filled with data.
  Future<User> login(String username, String password);

  Future<bool> requestResetCode(String userMail);

  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword);
}
