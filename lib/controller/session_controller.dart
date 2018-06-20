import 'dart:async';

import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
// import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();
  SessionController._internal();
  factory SessionController() => _instance;

  InetUserProvider _inetUserProvider;
  // CacheUserProvider _cacheUserProvider;
  User _user;

  bool get isLoggedIn => _user != null;
  User get user => _user;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory) {
    _inetUserProvider = inetProviderFactory.createUserProvider();
    // TODO _cacheUserProvider = cacheProviderFactory.createUserProvider();
  }

  Future<User> login(String email, String password) async {
    return _inetUserProvider.login(email, password).then((user) {
      _user = user;
      return user;
    });
  }
}
