import 'dart:async';

import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Mock user provider.
class MockInetUserProvider implements InetUserProvider {
  @override
  Future<User> login(String username, String password) async {
    return user;
  }

  @override
  Future<bool> logout(User user) async {
    return true;
  }

  @override
  Future<bool> requestResetCode(String userMail) async{
    return true;
  }

  @override
  Future<bool> resetPassword(String userMail, String resetCode, String newPassword) async {
    return true;
  }
}
