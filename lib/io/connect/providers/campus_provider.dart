import 'dart:async';

import 'package:courses_in_english/model/campus/campus.dart';

/// Provider for campuses.
abstract class InetCampusProvider {
  /// Return list of campuses.
  Future<List<Campus>> getCampuses();
}
