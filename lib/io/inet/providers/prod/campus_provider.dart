import 'dart:async';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';

/// Provider for campuses providing mock data.

//TODO Change Campus object design to fit server response

class ProdCampusProvider implements InetCampusProvider {
  final HttpHelper helper;

  ProdCampusProvider(this.helper);

  @override
  Future<List<Campus>> getCampuses() async => []; // todo implement this

  Campus parseCampus(Map<String, dynamic> json) {
    return new Campus(json['id'], json['name'], 'image', 'address');
  }
}
