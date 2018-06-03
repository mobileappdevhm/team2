import 'dart:ui';

/// Department representation.
class Department {
  /// Number of the department.
  final int number;

  /// Name of the department.
  final String name;

  /// Color of the department.
  final Color color;

  const Department(this.number, this.name, this.color);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.number;
    tempMap["number"] = this.number;
    tempMap["name"] = this.name;
    tempMap["color"] = int
        .parse(this.color.toString().split('(0x')[1].split(')')[0], radix: 16);
    return tempMap;
  }
}
