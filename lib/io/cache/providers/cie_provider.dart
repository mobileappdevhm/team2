import 'dart:async';

import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Provider for campuses.
abstract class CacheCieProvider {
  /// Return list of campuses.
  Future<List<Cie>> getCies(User user);

  Future<int> putCies(List<Cie> cies, User user);

  Future<int> putCie(Cie cie, User user);

  Future<int> removeCie(Cie cie);
}
