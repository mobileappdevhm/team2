import 'dart:async';

import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/model/department/department.dart';

class InMemoryDepartmentProvider implements CacheDepartmentProvider {
  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) {
    throw new UnimplementedError('InMemoryDepartmentProvider');
  }

  @override
  Future<Iterable<Department>> getDepartments() {
    throw new UnimplementedError('InMemoryDepartmentProvider');
  }

  @override
  Future<int> putDepartments(List<Department> departments) {
    throw new UnimplementedError('InMemoryDepartmentProvider');
  }
}
