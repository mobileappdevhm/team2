import 'dart:async';

import 'package:courses_in_english/io/mock_data.dart';
import 'package:courses_in_english/io/connect/mockito_inet_provider_factory.dart';
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

    session.setUpProviders(providerFactory);
  });
  test("Download", () {
    verifyZeroInteractions(providerFactory.userProvider);
    verifyZeroInteractions(providerFactory.userSettingsProvider);
    verifyZeroInteractions(providerFactory.lecturerProvider);
    verifyZeroInteractions(providerFactory.departmentProvider);
    verifyZeroInteractions(providerFactory.courseProvider);
    verifyZeroInteractions(providerFactory.campusProvider);
    verifyZeroInteractions(providerFactory.cieProvider);
    session.download();
    verifyZeroInteractions(providerFactory.userProvider);
    verifyZeroInteractions(providerFactory.cieProvider);
    verifyZeroInteractions(providerFactory.userSettingsProvider);
    untilCalled(providerFactory.lecturerProvider.getLecturers());
    untilCalled(providerFactory.departmentProvider.getDepartments());
    untilCalled(providerFactory.courseProvider.getFavorizedCourses());
    untilCalled(providerFactory.courseProvider.getSelectedCourses());
    untilCalled(providerFactory.courseProvider.getCourses());
    untilCalled(providerFactory.campusProvider.getCampuses());
  });
  test("Favorize", () {
    verifyZeroInteractions(providerFactory.courseProvider);
    session.favorize(course01);
    untilCalled(providerFactory.courseProvider.favorizeCourse(course01));
    verifyNever(providerFactory.courseProvider.unFavorizeCourse(course01));
  });
  test("Unfavorize", () {
    verifyZeroInteractions(providerFactory.courseProvider);
    session.unfavorize(course01);
    untilCalled(providerFactory.courseProvider.unFavorizeCourse(course01));
    verifyNever(providerFactory.courseProvider.favorizeCourse(course01));
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
  test("Login", () {
    verifyZeroInteractions(providerFactory.userProvider);
    session.login("test@hm.edu", "test1234");
    untilCalled(providerFactory.userProvider.login("test@hm.edu", "test1234"));
  });
}
