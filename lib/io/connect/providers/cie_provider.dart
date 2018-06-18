import 'dart:async';

import 'package:courses_in_english/model/cie/cie.dart';

/// Provider for campuses.
abstract class CieProvider {
  /// Return list of campuses.
  Future<List<Cie>> getCies();

  Future<int> putCies(List<Cie> cies);

  Future<int> putCie(Cie cie);

  void removeCie(Cie cie);
}
