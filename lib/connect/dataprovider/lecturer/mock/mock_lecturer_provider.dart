import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/mock_data.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class MockLecturerProvider implements LecturerProvider {
  static const Map<int, Lecturer> MOCK_LECTURERS = const <int, Lecturer>{
    0: lecturer01,
    1: lecturer02,
    2: lecturer03,
    3: lecturer04,
    4: lecturer05,
  };

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    return new Future.delayed(
        const Duration(milliseconds: 200), () => MOCK_LECTURERS[lecturerId]);
  }

  @override
  Future<Iterable<Lecturer>> getLecturers() async {
    // TODO: implement getLecturers
    return new Future(() => MOCK_LECTURERS.values);
  }
}
