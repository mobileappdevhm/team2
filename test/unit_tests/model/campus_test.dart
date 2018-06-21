import 'package:courses_in_english/model/campus/campus.dart';
import 'package:test/test.dart';

void main() {
  test('Test campus getters', () {
    Campus campus = new Campus(42, "Lothstrasse", "abcd", "Muenchen Lothstrasse");
    expect(campus.id, 42);
    expect(campus.name, "Lothstrasse");
    expect(campus.address, "Muenchen Lothstrasse");
    expect(campus.image, "abcd");
  });
  test('Test campus to map', () {
    Campus campus = new Campus(42, "Lothstrasse", "abcd", "Muenchen Lothstrasse");
    Map<String, dynamic> expected = {
      'id': 42,
      'name': 'Lothstrasse',
      'image': 'abcd',
      'address': 'Muenchen Lothstrasse'
    };
    expect(campus.toMap(), expected);
  });
}