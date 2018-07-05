import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:test/test.dart';

void main() {
  test("Test lecturer getters", () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', "mmustermann@hm.edu");
    expect(lecturer.name, "Max Mustermann");
    expect(lecturer.email, "mmustermann@hm.edu");
    expect(lecturer.id, 42);
  });
  test("Test lecturer toMap", () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', "mmustermann@hm.edu");
    Map<String, dynamic> expected = {
      'id': 42,
      'name': 'Max Mustermann',
      'email': 'mmustermann@hm.edu',
      'courseID': 1337 // TODO What is this?
    };
    expect(lecturer.toMap(), expected);
  });
}
