import 'dart:async';

import 'package:courses_in_english/model/user/user.dart';

/// Class that controls a single users session
abstract class SessionController {
  /// Returns true if the user is not a guest
  bool get isLoggedIn;

  /// Returns a user
  User get user;

  /// Logs in a user
  Future<User> login(String email, String password);

  /// Requests a password reset for the given email
  Future<bool> requestPasswordReset(String userMail);

  /// Sends the password reset request
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword);

  /// Logs out a certain user
  void logout();
}
