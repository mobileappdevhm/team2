import 'dart:async';

import 'package:courses_in_english/model/campus/campus.dart';

abstract class CacheCampusProvider {
  Future<List<Campus>> getCampuses();
  Future<int> putCampuses(List<Campus> campuses);
  Future<Campus> getCampusesById(int campusID);
}