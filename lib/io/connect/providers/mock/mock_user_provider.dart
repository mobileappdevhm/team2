import 'dart:async';

import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/io/mock_data.dart';

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
}
