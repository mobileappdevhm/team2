import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';

/// Provider for campuses providing mock data.

class ProdCampusProvider implements InetCampusProvider {
  final HttpHelper helper;

  ProdCampusProvider(this.helper);

  Future<List<dynamic>> _parseCampuses(String raw) async => json.decode(
        raw,
        reviver: (k, v) {
          if (k is num) return Campus.fromJsonMap(v);
          return v;
        },
      );

  @override
  Future<List<Campus>> getCampuses() async => helper
      .getCampusesAsJson()
      .then((raw) => _parseCampuses(raw))
      .then((list) => list.map((c) => c as Campus))
      .then((iterable) => iterable.toList());

  Campus parseCampus(Map<String, dynamic> json) {
    return new Campus(json['id'], json['name'], 'image', 'address');
  }
}
