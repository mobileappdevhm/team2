import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class ProdLecturerProvider implements InetLecturerProvider {
  final HttpHelper helper;

  ProdLecturerProvider(this.helper);

  Future<List<dynamic>> _parseLecturers(String raw) async => json.decode(
        raw,
        reviver: (k, v) {
          if (k is num) return Lecturer.fromJsonMap(v);
          return v;
        },
      );

  @override
  Future<List<Lecturer>> getLecturers() async {
    return helper
        .getLecturersAsJson()
        .then((raw) => _parseLecturers(raw))
        .then((list) => list.map((c) => c as Lecturer))
        .then((iterable) => iterable.toList());
  }

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    throw new UnimplementedError();
  }
}
