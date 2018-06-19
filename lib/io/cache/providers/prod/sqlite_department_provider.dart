import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/model/department/department.dart';

class SqliteDepartmentProvider implements CacheDepartmentProvider {
  final DatabaseHelper dbh;

  SqliteDepartmentProvider(this.dbh);
  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) async =>
          dbh.selectOneWhere("Department", "number", departmentNumber.toString())
          .then(
            (rawElement) => new Department(
                  rawElement["id"],
                  rawElement["number"],
                  rawElement["name"],
                  rawElement["color"],
                ),
          );

  @override
  Future<Iterable<Department>> getDepartments() async =>
      dbh.selectTable("Department").then(
            (rawData) => rawData.map(
                  // map each raw element into a department
                  (rawElement) => new Department(
                        rawElement["id"],
                        rawElement["number"],
                        rawElement["name"],
                        rawElement["color"],
                      ),
                ),
          );

  Future<int> putDepartments(List<Department> departments) async =>
      dbh.insertTable(
        "Department",
        departments
            .map(
              // map each department into raw data
              (department) => department.toMap(),
            )
            .toList(),
      );
}
