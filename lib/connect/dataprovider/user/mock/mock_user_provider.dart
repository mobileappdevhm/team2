import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/connect/dataprovider/mock_data.dart';

/// Mock user provider.
class MockUserProvider implements UserProvider {
  @override
  Future<User> login(String username, String password) async {
    return user;
  }

  @override
  Future<bool> logout(User user) async {
    return true;
  }
}
