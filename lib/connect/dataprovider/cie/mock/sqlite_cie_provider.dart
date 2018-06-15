import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/cie/cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';
import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/cie/cie.dart';

/// Provider for campuses providing mock data.
class SqliteCieProvider implements CieProvider {
  @override
  Future<List<Cie>> getCies() async {
    List<Cie> campuses = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawCampusData =
        await dbh.selectWhere("Cie", "userId", new Session().user.id);

    void iterate(Map<String, dynamic> data) {
      campuses.add(new Cie(data["name"], data["department"],
          data["lecturerName"], data["ects"], data["id"]));
    }

    rawCampusData.forEach(iterate);

    return (new Future(() => campuses));
  }

  @override
  Future<int> putCies(List<Cie> cies) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> cieList = [];

    void iterate(Cie data) {
      cieList.add(data.toMap().putIfAbsent("userId", new Session().user.id));
    }

    cies.forEach(iterate);

    return dbh.insertTable("Cie", cieList);
  }

  @override
  Future<int> putCie(Cie cie) async {
    return putCies([cie]);
  }

  Future<int> removeCie(Cie cie) async {
    DatabaseHelper dbh = new DatabaseHelper();

    return dbh.deleteWhere("Cie", "id", cie.id.toString());
    //return dbh.truncateTable("Cie");
  }
}
