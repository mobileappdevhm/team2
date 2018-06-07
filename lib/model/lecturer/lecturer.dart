/// Representation of a lecturer.
class Lecturer {
  /// Name of the lecturer
  final String name;

  /// Email address of the lecturer
  final String email;

  /// id of the lecturer
  final int id;

  const Lecturer(this.id, this.name, this.email);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["id"] = this.id;
    tempMap["name"] = this.name;
    tempMap["email"] = this.email;
    return tempMap;
  }
}
