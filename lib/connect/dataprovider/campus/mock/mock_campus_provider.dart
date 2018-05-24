import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';

/// Provider for campuses providing mock data.
class MockCampusProvider implements CampusProvider {
  static const List<Campus> CAMPUSES = const <Campus>[
    const Campus(0, "Lothstraße", "res/location/campus_lothstr.png"),
    const Campus(1, "Karlstraße", "res/location/campus_karlstr.png"),
    const Campus(2, "Pasing", "res/location/campus_pasing.png")
  ];

  @override
  Future<List<Campus>> getCampuses() async =>
      new Future.delayed(const Duration(seconds: 2), () => CAMPUSES);
}
