import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:test/test.dart';

void main() {
  test('Test course getters', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      null,
      lecturer,
      department,
      campus,
      [],
    );
    expect(course.id, 420);
    expect(course.name, 'appdev');
    expect(course.description, 'beschreibung');
    expect(course.room, 'R2.012');
    expect(course.availableSlots, 20);
    expect(course.ects, 5.0);
    expect(course.usCredits, 4.0);
    expect(course.semesterWeekHours, 3.0);
    expect(course.lecturer, lecturer);
    expect(course.department, department);
    expect(course.location, campus);
    expect(course.dates, []);
  });
  test('Test course status getter RED', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.RED,
      lecturer,
      department,
      campus,
      [],
    );
    expect(course.courseStatus, CourseStatus.RED);
  });
  test('Test course status getter YELLOW', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.YELLOW,
      lecturer,
      department,
      campus,
      [],
    );
    expect(course.courseStatus, CourseStatus.YELLOW);
  });
  test('Test course status getter GREEN', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.GREEN,
      lecturer,
      department,
      campus,
      [],
    );
    expect(course.courseStatus, CourseStatus.GREEN);
  });
  test('Test course to map - status GREEN', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.GREEN,
      lecturer,
      department,
      campus,
      [],
    );
    Map<String, dynamic> expected = {
      'id': 420,
      'name': 'appdev',
      'location': 2,
      'description': 'beschreibung',
      'department': 7,
      'lecturer': 42,
      'room': 'R2.012',
      'courseStatus': 'GREEN',
      'availableSlots': 20,
      'ects': 5.0,
      'usCredits': 4.0,
      'semesterWeekHours': 3.0
    };
    expect(course.toMap(), expected);
  });
  test('Test course to map - status RED', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.RED,
      lecturer,
      department,
      campus,
      [],
    );
    Map<String, dynamic> expected = {
      'id': 420,
      'name': 'appdev',
      'location': 2,
      'description': 'beschreibung',
      'department': 7,
      'lecturer': 42,
      'room': 'R2.012',
      'courseStatus': 'RED',
      'availableSlots': 20,
      'ects': 5.0,
      'usCredits': 4.0,
      'semesterWeekHours': 3.0
    };
    expect(course.toMap(), expected);
  });
  test('Test course to map - status YELLOW', () {
    Lecturer lecturer =
        new Lecturer(42, 'Max Mustermann', 'mmustermann@hm.edu');
    Department department = new Department(13, 7, 'Fakultaet 07', 1337);
    Campus campus = new Campus(2, 'Lothstrasse', 'abcd', 'Lothstr.');
    Course course = new Course(
      420,
      'appdev',
      'beschreibung',
      'R2.012',
      20,
      5.0,
      4.0,
      3.0,
      CourseStatus.YELLOW,
      lecturer,
      department,
      campus,
      [],
    );
    Map<String, dynamic> expected = {
      'id': 420,
      'name': 'appdev',
      'location': 2,
      'description': 'beschreibung',
      'department': 7,
      'lecturer': 42,
      'room': 'R2.012',
      'courseStatus': 'YELLOW',
      'availableSlots': 20,
      'ects': 5.0,
      'usCredits': 4.0,
      'semesterWeekHours': 3.0
    };
    expect(course.toMap(), expected);
  });
}
