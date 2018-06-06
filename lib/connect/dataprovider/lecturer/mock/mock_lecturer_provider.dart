import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class MockLecturerProvider implements LecturerProvider {
  static const Map<int, Lecturer> MOCK_LECTURERS = const <int, Lecturer>{
    0: const Lecturer(0, "Socher", "test@hm.edu"),
    1: const Lecturer(1, "Schuckmann", "test@hm.edu"),
    2: const Lecturer(2, "Pötter", "test@hm.edu"),
    3: const Lecturer(3, "Koebler", "test@hm.edu"),
    4: const Lecturer(4, "Wolfsteiner", "test@hm.edu")
  };

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    return new Future.delayed(
        const Duration(milliseconds: 200), () => MOCK_LECTURERS[lecturerId]);
  }
}
