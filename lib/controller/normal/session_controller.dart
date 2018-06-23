import 'dart:async';

import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class NormalSessionController implements SessionController {
  final InetUserProvider inetUserProvider;
  final CacheUserProvider cacheUserProvider;

  NormalSessionController(
      CacheProviderFactory cacheFactory, InetProviderFactory inetFactory)
      : inetUserProvider = inetFactory.createUserProvider(),
        cacheUserProvider = cacheFactory.createCacheUserProvider();

  User _user;

  @override
  bool get isLoggedIn => _user != null;

  @override
  User get user => _user;

  @override
  Future<User> login(String email, String password) async {
    return inetUserProvider.login(email, password).then((user) {
      _user = user;
      //await _CacheUserProvider.login(user);
      //TODO CACHE USERS AND SETTINS
      return user;
    });
  }
}
