import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/cie/cie.dart';

/// Provider for campuses providing mock data.
class SqliteCieProvider implements CacheCieProvider {
  final DatabaseHelper dbh;

  SqliteCieProvider(this.dbh);

  @override
  Future<List<Cie>> getCies() async {
    List<Cie> campuses = [];
    List<Map<String, dynamic>> rawCampusData = await dbh.selectWhere(
        "Cie", "userId", new Session().user.id.toString());

    void iterate(Map<String, dynamic> data) {
      campuses.add(new Cie(data["name"], data["department"],
          data["lecturerName"], data["ects"], data["id"]));
    }

    rawCampusData.forEach(iterate);

    return (new Future(() => campuses));
  }

  @override
  Future<int> putCies(List<Cie> cies) async {
    List<Map<String, dynamic>> cieList = [];

    cies.map((cie) => cie.toMap()).forEach((raw) {
      raw.putIfAbsent("userId", () => new Session().user.id);
      cieList.add(raw);
    });

    return dbh.insertTable("Cie", cieList);
  }

  @override
  Future<int> putCie(Cie cie) async {
    return putCies([cie]);
  }

  @override
  Future<int> removeCie(Cie cie) async {
    return dbh.deleteWhere("Cie", "id", cie.id.toString());
    //return dbh.truncateTable("Cie");
  }
}
