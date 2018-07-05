import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';

/// Provider for campuses providing mock data.
class SqliteCampusProvider implements CacheCampusProvider {
  final DatabaseHelper dbh;

  SqliteCampusProvider(this.dbh);

  @override
  Future<List<Campus>> getCampuses() async {
    List<Campus> campuses = [];
    List<Map<String, dynamic>> rawCampusData = await dbh.selectTable("Campus");

    void iterate(Map<String, dynamic> data) {
      campuses.add(
          new Campus(data['id'], data["name"], data["image"], data["address"]));
    }

    rawCampusData.forEach(iterate);

    return (new Future(() => campuses));
  }

  @override
  Future<Campus> getCampusesById(int campusID) async {
    Map<String, dynamic> data =
        await dbh.selectOneWhere("Campus", "id", campusID.toString());

    return (new Future(() =>
        new Campus(data['id'], data["name"], data["image"], data["address"])));
  }

  @override
  Future<int> putCampuses(List<Campus> campuses) async {
    int affected = await dbh.getCount("Campus");
    if (affected != campuses.length) {
      print("Jep");
      List<Map<String, dynamic>> campusesList = [];

      void iterate(Campus data) {
        campusesList.add(data.toMap());
      }

      campuses.forEach(iterate);

      await dbh.insertTable("Campus", campusesList);
    }
    return 0;
  }

  Future<int> truncate() {
    dbh.truncateTable("Campus");
    return new Future(() => 0);
  }
}
