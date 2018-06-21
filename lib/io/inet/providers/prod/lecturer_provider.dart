import 'dart:async';

import 'package:courses_in_english/io/inet/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class ProdLecturerProvider implements InetLecturerProvider {
  final HttpHelper helper;

  ProdLecturerProvider(this.helper);

  @override
  Future<List<Lecturer>> getLecturers() async => helper
      .getLecturers()
      .then((list) => list.map((lecturer) => parseLecturer(lecturer)).toList());

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    throw new UnimplementedError();
  }

  static Lecturer parseLecturer(Map<String, dynamic> json) {
    return new Lecturer(json['id'], json['name'], json['email']);
  }
}
