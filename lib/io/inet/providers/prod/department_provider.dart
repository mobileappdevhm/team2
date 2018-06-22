import 'dart:async';

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
  Future<List<Department>> getDepartments() async =>
      helper.getDepartments().then((list) =>
          list.map((department) => parseDepartment(department)).toList());

  //TODO: Change Department Object to fit server response
  static Department parseDepartment(Map<String, dynamic> json) {
    if (json == null) return new Department(-1, -1, 'None', 0);
    return new Department(
        json['number'], json['number'], json['name'], json['color']);
  }
}
