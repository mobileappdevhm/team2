import 'dart:async';

import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

abstract class CieController {
  /// Has to be called right after login.
  set user(User user);

  void addObserver(CieListObserver observer);

  Future<int> enterCie(Cie cie);

  Future<int> removeCie(Cie cie);

  Future<List<Cie>> get cies;
}

abstract class CieListObserver {
  void onCieListUpdate(List<Cie> cies);
}
