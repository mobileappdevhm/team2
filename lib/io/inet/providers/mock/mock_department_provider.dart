import 'dart:async';

import 'package:courses_in_english/io/inet/providers/department_provider.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/model/department/department.dart';

/// Mock department provider holding mock department data.
class MockInetDepartmentProvider implements InetDepartmentProvider {
  static const Map<int, Department> MOCK_DEPARTMENTS = <int, Department>{
    1: department01,
    2: department02,
    3: department03,
    4: department04,
    5: department05,
    6: department06,
    7: department07,
    8: department08,
    9: department09,
    10: department10,
    11: department11,
    12: department12,
    13: department13,
    14: department14,
  };

  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) async {
    return new Future.delayed(const Duration(milliseconds: 200),
        () => MOCK_DEPARTMENTS[departmentNumber]);
  }

  @override
  Future<List<Department>> getDepartments() async => new Future.delayed(
        const Duration(milliseconds: 300),
        () => MOCK_DEPARTMENTS.values.toList(),
      );
}
