import 'dart:async';

import 'package:courses_in_english/model/department/department.dart';

/// Provider for departments.
abstract class InetDepartmentProvider {
  /// Get all departments.
  Future<List<Department>> getDepartments();

  /// Get a department by its number.
  Future<Department> getDepartmentByNumber(int departmentNumber);
}
