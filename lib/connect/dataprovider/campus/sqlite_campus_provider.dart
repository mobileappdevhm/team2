import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

/// Provider for campuses providing mock data.
class SqliteCampusProvider implements CampusProvider {
  @override
  Future<List<Campus>> getCampuses() async {
    List<Campus> campuses = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawCampusData = await dbh.selectTable("Campus");

    void iterate(Map<String, dynamic> data) {
      campuses.add(new Campus(data['id'], data["name"], data["imagePath"]));
    }

    rawCampusData.forEach(iterate);

    return (new Future.delayed(const Duration(seconds: 1), () => campuses));
  }

  Future<int> putCampuses(List<Campus> campuses) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> campusesList = [];

    void iterate(Campus data) {
      campusesList.add(data.toMap());
    }

    campuses.forEach(iterate);

    return dbh.insertTable("Campus", campusesList);
  }
}
