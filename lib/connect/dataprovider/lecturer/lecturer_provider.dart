import 'dart:async';

import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Provider for lecturers.
abstract class LecturerProvider {
  /// Get lecturer by its id.
  Future<Lecturer> getLecturerById(int lecturerId);
}
