import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

class SqliteDepartmentProvider implements DepartmentProvider {
  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) async =>
      new DatabaseHelper()
          .selectOneWhere("Department", "number", departmentNumber.toString())
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
      new DatabaseHelper().selectTable("Department").then(
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
      new DatabaseHelper().insertTable(
        "Department",
        departments
            .map(
              // map each department into raw data
              (department) => department.toMap(),
            )
            .toList(),
      );
}
