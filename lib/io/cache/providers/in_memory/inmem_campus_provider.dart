import 'dart:async';

import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';

class InMemoryCampusProvider implements CacheCampusProvider {
  @override
  Future<List<Campus>> getCampuses() {
    throw new UnimplementedError('InMemoryCampusProvider not implemented yet');
  }

  @override
  Future<Campus> getCampusesById(int campusID) {
    throw new UnimplementedError('InMemoryCampusProvider not implemented yet');
  }

  @override
  Future<int> putCampuses(List<Campus> campuses) {
    throw new UnimplementedError('InMemoryCampusProvider not implemented yet');
  }
}
