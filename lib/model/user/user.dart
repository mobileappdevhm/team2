import 'package:courses_in_english/model/department/department.dart';

/// User representation.
class User {
  /// ID of the user
  final int id;

  /// Username (alias)
  final String username;

  /// First name of the user
  final String firstName;

  /// Last name of the user
  final String lastName;

  /// Department number the user is belonging to.
  final Department department;

  final String token;

  const User(
    this.username,
    this.firstName,
    this.lastName,
    this.department,
    this.token, [
    this.id,
  ]);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();
    tempMap["username"] = this.username;
    tempMap["firstName"] = this.firstName;
    tempMap["lastName"] = this.lastName;
    tempMap["department"] = department.number;
    tempMap["token"] = token;
    return tempMap;
  }
}
