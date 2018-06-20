import 'dart:async';

import 'package:courses_in_english/controller/firebase_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
// import 'package:courses_in_english/io/cache/providers/user_provider.dart';

class SessionController {
  static final SessionController _instance = SessionController._internal();

  SessionController._internal();

  factory SessionController() => _instance;

  InetUserProvider _inetUserProvider;
  FirebaseController _firebaseController;

  // CacheUserProvider _cacheUserProvider;
  User _user;

  bool get isLoggedIn => _user != null;

  User get user => _user;

  void injectDependencies(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory, [FirebaseController firebase]) {
    _inetUserProvider = inetProviderFactory.createUserProvider();
    if (firebase != null) {
      _firebaseController = firebase;
    }
    // TODO _cacheUserProvider = cacheProviderFactory.createUserProvider();
  }

  Future<User> login(String email, String password) async {
    return _inetUserProvider.login(email, password).then((user) {
      _user = user;
      _firebaseController.logLogin();
      if (user != null) {
        _firebaseController.logUserParameter(
            name: "department", value: user.department.toString());
      }
      return user;
    });
  }
}
