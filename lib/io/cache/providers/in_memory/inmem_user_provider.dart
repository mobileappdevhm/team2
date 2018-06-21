import 'dart:async';

import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class InMemoryUserProvider implements CacheUserProvider {
  @override
  Future<User> login(String username, String password) {
    throw new UnimplementedError('InMemoryUserProvider');
  }

  @override
  Future<bool> logout(User user) {
    throw new UnimplementedError('InMemoryUserProvider');
  }
}
