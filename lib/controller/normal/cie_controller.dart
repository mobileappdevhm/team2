import 'dart:async';

import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

class NormalCieController implements CieController {
  List<CieListObserver> _observers = [];
  final CacheCieProvider cieProvider;
  User _user;

  NormalCieController(CacheProviderFactory factory)
      : this.cieProvider = factory.createCieProvider();

  /// Has to be called right after login.
  set user(User user) => _user = user;

  @override
  void addObserver(CieListObserver observer) {
    _observers.add(observer);
    cies.then((cies) => observer.onCieListUpdate(cies)).catchError((e) => null);
  }

  @override
  Future<int> enterCie(Cie cie) async {
    int result = await cieProvider.putCie(cie, _user);
    cies.then((cies) =>
        _observers.forEach((observer) => observer.onCieListUpdate(cies)));
    return result;
  }

  @override
  Future<int> removeCie(Cie cie) async {
    int result = await cieProvider.removeCie(cie);
    cies.then((cies) =>
        _observers.forEach((observer) => observer.onCieListUpdate(cies)));
    return result;
  }

  @override
  Future<List<Cie>> get cies async => cieProvider.getCies(_user);
}
