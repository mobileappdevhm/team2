// Representation of a lecturer.
class Lecturer {
  /// Name of the lecturer
  final String name;

  /// Email address of the lecturer
  final String email;

  /// id of the lecturer
  final int id;

  const Lecturer(this.id, this.name, this.email);

  factory Lecturer.fromJsonMap(Map<String, dynamic> map) => map != null
      ? Lecturer(map['id'] ?? -1, map['name'] ?? 'unknown', map['email'] ?? '')
      : Lecturer(-1, 'unknown', '');

  Map<String, dynamic> toMap(int courseID) {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["email"] = this.email;
    tempMap["courseID"] = courseID;
    return tempMap;
  }
}
