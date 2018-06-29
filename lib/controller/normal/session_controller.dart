import 'dart:async';

import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NormalSessionController implements SessionController {
  final InetUserProvider inetUserProvider;
  final CacheUserProvider cacheUserProvider;
  SharedPreferences preferences;

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
    this.preferences = await SharedPreferences.getInstance();
    if (preferences.getString("userToken") != null &&
        preferences.getString("userToken") != "") {
      return cacheUserProvider.login(preferences.getString("userToken"));
    } else {
      return inetUserProvider.login(email, password).then((user) {
        _user = user;
        if (user != null) {
          preferences.setString("userToken", user.token);
          cacheUserProvider.save(user);
        }
        return user;
      });
    }
  }

  @override
  Future<bool> requestPasswordReset(String userMail) {
    return inetUserProvider.requestResetCode(userMail);
  }

  @override
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword) {
    return inetUserProvider.resetPassword(userMail, resetCode, newPassword);
  }

  @override
  void logout() {
    cacheUserProvider.logout(user.token);
    preferences.clear();
  }
}
