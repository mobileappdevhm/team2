import 'dart:async';
import 'dart:ui';

import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

/// Mock department provider holding mock department data.
class SqliteDepartmentProvider implements DepartmentProvider {
  static const Map<int, Department> MOCK_DEPARTMENTS = const <int, Department>{
    1: const Department(1, "Architecture", const Color(0xFF014085)),
    2: const Department(2, "Civil Engineering", const Color(0xFF008db8)),
    3: const Department(
        3,
        "Mechanical, Automotive and Aeronautical Engineering",
        const Color(0xFF018bc9)),
    4: const Department(4, "Electrical Engineering and Information Technology",
        const Color(0xFF0198ab)),
    5: const Department(
        5,
        "Building Services Engineering, Paper and Packaging Technology and Print and Media Technology",
        const Color(0xFF016fb2)),
    6: const Department(
        6, "Applied Sciences and Mechatronics", const Color(0xFF04539d)),
    7: const Department(
        7, "Computer Science and Mathematics", const Color(0xFF029fd0)),
    8: const Department(8, "Geoinformatics", const Color(0xFF018a8a)),
    9: const Department(
        9, "Engineering and Management", const Color(0xFF018e62)),
    10: const Department(
        10, "Business Administration", const Color(0xFF028d7c)),
    11: const Department(
        11, "Applied Social Sciences", const Color(0xFFed7406)),
    12: const Department(12, "Design", const Color(0xFF0f3647)),
    13: const Department(
        13, "General and Interdisciplinary Studies", const Color(0xFFbf0179)),
    14: const Department(14, "Tourism", const Color(0xFFa41948))
  };

  @override
  Future<Department> getDepartmentByNumber(int departmentNumber) async {
    DatabaseHelper dbh = new DatabaseHelper();
    Map<String, dynamic> departmentData = await dbh.selectOneWhere(
        "Department", "id", departmentNumber.toString());
    Department tempDepartment = new Department(departmentData["id"],
        departmentData["name"], new Color(departmentData["color"]));
    return new Future.delayed(
        const Duration(milliseconds: 200), () => tempDepartment);
  }

  @override
  Future<Iterable<Department>> getDepartments() async {
    List<Department> departments = [];
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> rawDepartmentData =
        await dbh.selectTable("Department");

    void addDepartment(Map<String, dynamic> data) {
      Department tempDepartment =
          new Department(data["id"], data["name"], new Color(data["color"]));

      departments.add(tempDepartment);
    }

    rawDepartmentData.forEach(addDepartment);

    return new Future.delayed(
        const Duration(milliseconds: 300), () => departments);
  }

  Future<int> putDepartments(List<Department> departments) async {
    DatabaseHelper dbh = new DatabaseHelper();
    List<Map<String, dynamic>> departmentList = [];

    void iterate(Department data) {
      departmentList.add(data.toMap());
    }

    departments.forEach(iterate);

    return dbh.insertTable("Department", departmentList);
  }
}
