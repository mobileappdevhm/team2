import 'dart:async';

import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Provider for lecturers.
abstract class CacheLecturerProvider {
  /// Get lecturer by its id.
  Future<Lecturer> getLecturerById(int lecturerId);
  Future<Iterable<Lecturer>> getLecturers();
}
