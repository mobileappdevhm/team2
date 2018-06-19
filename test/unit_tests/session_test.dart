import 'dart:async';

import 'package:courses_in_english/io/cache/sqlite_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  Session session = new Session();
  MockitoProviderFactory providerFactory;
  setUp(() async {
    providerFactory = new MockitoProviderFactory();
    when(providerFactory.lecturerProvider.getLecturers())
        .thenAnswer((_) => new Future<List<Lecturer>>(() => []));
    when(providerFactory.departmentProvider.getDepartments())
        .thenAnswer((_) => new Future<List<Department>>(() => []));
    when(providerFactory.courseProvider.getFavorizedCourses())
        .thenAnswer((_) => new Future<List<Course>>(() => []));
    when(providerFactory.courseProvider.getSelectedCourses())
        .thenAnswer((_) => new Future<List<Course>>(() => []));
    when(providerFactory.courseProvider.getCourses())
        .thenAnswer((_) => new Future<List<Course>>(() => []));
    when(providerFactory.campusProvider.getCampuses())
        .thenAnswer((_) => new Future<List<Campus>>(() => []));

    when(providerFactory.courseProvider.favorizeCourse(course01))
        .thenAnswer((_) => new Future(() => true));
    when(providerFactory.courseProvider.unFavorizeCourse(course01))
        .thenAnswer((_) => new Future(() => false));

    when(providerFactory.userProvider.login("test@hm.edu", "test1234"))
        .thenAnswer((_) => new Future(() => user));

    // TODO Mock cache provider out
    session.setUpProviders(providerFactory, new SqliteProviderFactory());
  });
  test("Test getters", () {
    // Expect empty lists
    expect(session.lecturers, []);
    expect(session.departments, []);
    expect(session.campuses, []);
    expect(session.favorites, []);
    expect(session.selected, []);
    expect(session.courses, []);
  });
}
