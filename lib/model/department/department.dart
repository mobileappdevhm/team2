/// Department representation.
class Department {
  final int id;

  /// Number of the department.
  final int number;

  /// Name of the department.
  final String name;

  /// Color of the department.
  final int color;

  int get flutterColor => color + 0xFF000000; // Remove Transparency

  const Department(
    this.id,
    this.number,
    this.name,
    this.color,
  );

  factory Department.fromJsonMap(Map<String, dynamic> map) => map != null
      ? Department(map['number'] ?? -1, map['number'] ?? -1,
          map['name'] ?? 'unknown', map['color'] ?? 0)
      : Department(-1, -1, 'unknown', 0);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["number"] = this.number;
    tempMap["name"] = this.name;
    tempMap["color"] = this.color;
    return tempMap;
  }
}
