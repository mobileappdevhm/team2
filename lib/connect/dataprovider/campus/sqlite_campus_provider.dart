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
      campuses.add(
          new Campus(data['id'], data["name"], data["image"], data["address"]));
    }

    rawCampusData.forEach(iterate);

    return (new Future(() => campuses));
  }

  Future<Campus> getCampusesById(int campusID) async {
    DatabaseHelper dbh = new DatabaseHelper();
    Map<String, dynamic> data =
        await dbh.selectOneWhere("Campus", "id", campusID.toString());

    return (new Future(() =>
        new Campus(data['id'], data["name"], data["image"], data["address"])));
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