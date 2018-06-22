import 'dart:async';

import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

class InMemoryLecturerProvider implements CacheLecturerProvider {
  @override
  Future<Lecturer> getLecturerById(int lecturerId) {
    throw new UnimplementedError('InMemoryLecturerProvider');
  }

  @override
  Future<Iterable<Lecturer>> getLecturers() {
    throw new UnimplementedError('InMemoryLecturerProvider');
  }

  @override
  Future<int> putLecturers(List<Lecturer> lecturers) {
    throw new UnimplementedError('InMemoryLecturerProvider');
  }
}
