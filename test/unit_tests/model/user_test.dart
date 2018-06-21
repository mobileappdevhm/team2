import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:test/test.dart';

void main() {
  test('Test user getters', () {
    Department department = new Department(1, 1, "a", 0);
    User user = new User(42, "benutzername", "vorname", "nachname", department, "token");
    expect(user.id, 42);
    expect(user.username, "benutzername");
    expect(user.firstName, "vorname");
    expect(user.lastName, "nachname");
    expect(user.department, department);
    expect(user.token, "token");
  });
}