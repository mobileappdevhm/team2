/// Department representation.
class Department {
  final int id;

  /// Number of the department.
  final int number;

  /// Name of the department.
  final String name;

  /// Color of the department.
  final int color;

  const Department([
    this.id,
    this.number,
    this.name,
    this.color,
  ]);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["number"] = this.number;
    tempMap["name"] = this.name;
    tempMap["color"] = this.color;
    return tempMap;
  }
}
