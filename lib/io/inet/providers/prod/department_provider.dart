import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/department_provider.dart';
import 'package:courses_in_english/model/department/department.dart';

/// Mock department provider holding mock department data.
class ProdDepartmentProvider implements InetDepartmentProvider {
  HttpHelper helper;

  ProdDepartmentProvider(this.helper);

  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) async {
    throw new UnimplementedError();
  }

  @override
  Future<List<Department>> getDepartments() async => helper
      .getDepartmentsAsJson()
      .then((raw) => parseDepartments(raw))
      .then((list) => list.map((d) => d as Department))
      .then((iterable) => iterable.toList());

  Future<List<dynamic>> parseDepartments(String raw) async =>
      json.decode(raw, reviver: (k, v) {
        if (k is num) return Department.fromJsonMap(v);
        return v;
      });
}
