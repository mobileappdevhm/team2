import 'dart:async';

import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

class InMemoryCieProvider implements CacheCieProvider {
  Map<User, Set<Cie>> storage = new Map();

  @override
  Future<List<Cie>> getCies(User user) async {
    storage.putIfAbsent(user, () => new Set());
    return storage[user].toList(growable: false);
  }

  @override
  Future<int> putCie(Cie cie, User user) async {
    storage.putIfAbsent(user, () => new Set());
    return storage[user].add(cie) ? 0 : -1;
  }

  @override
  Future<int> putCies(List<Cie> cies, User user) async {
    storage.putIfAbsent(user, () => new Set());
    return cies
        .map((cie) async => await putCie(cie, user))
        .reduce((a, b) async => await a + await b);
  }

  @override
  Future<int> removeCie(Cie cie) async {
    storage.forEach((u, s) => s.remove(cie));
    return 0;
  }
}
