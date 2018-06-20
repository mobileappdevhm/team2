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
  User _user;

  void injectDependencies(CacheProviderFactory factory) {
    _cieProvider = factory.createCieProvider();
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
    new FirebaseController().logEvent(name: "add_cie");
    return result;
  }

  Future<int> removeCie(Cie cie) async {
    int result = await _cieProvider.removeCie(cie);
    cies.then((cies) =>
        _observers.forEach((observer) => observer.onCieListUpdate(cies)));
    new FirebaseController().logEvent(name: "remove_cie");
    return result;
  }

  Future<List<Cie>> get cies async => _cieProvider.getCies(_user);
}

abstract class CieListObserver {
  void onCieListUpdate(List<Cie> cies);
}
