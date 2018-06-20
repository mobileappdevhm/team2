import 'dart:async';

import 'package:courses_in_english/controller/firebase_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

class CieController {
  static final CieController _instance = CieController._internal();

  CieController._internal();

  factory CieController() => _instance;

  List<CieListObserver> _observers = [];
  CacheCieProvider _cieProvider;
  FirebaseController _firebaseController;
  User _user;

  void injectDependencies(CacheProviderFactory factory,
      [FirebaseController firebase]) {
    _cieProvider = factory.createCieProvider();
    if (firebase != null) {
      _firebaseController = firebase;
    }
  }

  /// Has to be called right after login.
  set user(User user) => _user = user;

  void addObserver(CieListObserver observer) {
    _observers.add(observer);
    cies.then((cies) => observer.onCieListUpdate(cies)).catchError((e) => null);
  }

  Future<int> enterCie(Cie cie) async {
    int result = await _cieProvider.putCie(cie, _user);
    cies.then((cies) =>
        _observers.forEach((observer) => observer.onCieListUpdate(cies)));
    _firebaseController?.logEvent(name: "add_cie");
    _cieProvider.getCies(_user).then((List<Cie> value) {
      if (value != null) {
        String ammount = value.length.toString();
        _firebaseController?.logUserParameter(
            name: "custom_courses", value: ammount);
      }
    });
    return result;
  }

  Future<int> removeCie(Cie cie) async {
    int result = await _cieProvider.removeCie(cie);
    cies.then((cies) =>
        _observers.forEach((observer) => observer.onCieListUpdate(cies)));
    _firebaseController?.logEvent(name: "remove_cie");
    _cieProvider.getCies(_user).then((List<Cie> value) {
      if (value != null) {
        String ammount = value.length.toString();
        _firebaseController?.logUserParameter(
            name: "custom_courses", value: ammount);
      }
    });
    return result;
  }

  Future<List<Cie>> get cies async => _cieProvider.getCies(_user);
}

abstract class CieListObserver {
  void onCieListUpdate(List<Cie> cies);
}
