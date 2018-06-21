import 'package:courses_in_english/model/department/department.dart';
import 'package:test/test.dart';

void main() {
  test('Test department getters', () {
    Department department = new Department(42, 7, "fakultaet 07", 1337);
    expect(department.id, 42);
    expect(department.number, 7);
    expect(department.name, "fakultaet 07");
    expect(department.color, 1337);
  });
  test('Test department to map', () {
    Department department = new Department(42, 7, "fakultaet 07", 1337);
    Map<String, dynamic> expected = {
      'id': 42,
      'number': 7,
      'name': 'fakultaet 07',
      'color': 1337
    };
    expect(department.toMap(), expected);
  });
}