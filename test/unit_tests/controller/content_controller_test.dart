import 'dart:async';

import 'package:courses_in_english/controller/content_controller.dart';
import 'package:courses_in_english/controller/normal/content_controller.dart';
import 'package:courses_in_english/io/cache/mocked_providers_factory.dart';
import 'package:courses_in_english/io/inet/mockito_inet_provider_factory.dart';
import 'package:courses_in_english/io/mock_data.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  ContentController controller;
  MockedCacheProvidersFactory cacheFactory;
  MockitoProviderFactory inetFactory;
  setUp(() {
    cacheFactory = new MockedCacheProvidersFactory();
    inetFactory = new MockitoProviderFactory();
    controller = new NormalContentController(inetFactory, cacheFactory);
  });
  test('Test ContentController.getCourses', () async {
    when(inetFactory.courseProvider.getCourses())
        .thenAnswer((_) => Future.value([course01, course02]));
    verifyZeroInteractions(inetFactory.courseProvider);
    var courses = await controller.getCourses();
    verify(inetFactory.courseProvider.getCourses()).called(1);
    expect(courses, [course01, course02]);
  });
  test('Test ContentController.getCampuses', () async {
    when(inetFactory.campusProvider.getCampuses())
        .thenAnswer((_) => Future.value([campus01, campus02, campus03]));
    verifyZeroInteractions(inetFactory.campusProvider);
    var campuses = await controller.getCampuses();
    verify(inetFactory.campusProvider.getCampuses()).called(1);
    expect(campuses, [campus01, campus02, campus03]);
  });
  test('Test ContentController.getDepartments', () async {
    when(inetFactory.departmentProvider.getDepartments())
        .thenAnswer((_) => Future.value([department07, department04]));
    verifyZeroInteractions(inetFactory.departmentProvider);
    var departments = await controller.getDepartments();
    verify(inetFactory.departmentProvider.getDepartments()).called(1);
    expect(departments, [department07, department04]);
  });
  test('Test ContentController.getLecturers', () async {
    when(inetFactory.lecturerProvider.getLecturers())
        .thenAnswer((_) => Future.value([lecturer03, lecturer05]));
    verifyZeroInteractions(inetFactory.lecturerProvider);
    var lecturers = await controller.getLecturers();
    verify(inetFactory.lecturerProvider.getLecturers()).called(1);
    expect(lecturers, [lecturer03, lecturer05]);
  });
  test('Test ContentController.getContent', () async {
    when(inetFactory.courseProvider.getCourses())
        .thenAnswer((_) => Future.value([course01, course02]));
    when(inetFactory.campusProvider.getCampuses())
        .thenAnswer((_) => Future.value([campus01, campus02, campus03]));
    when(inetFactory.departmentProvider.getDepartments())
        .thenAnswer((_) => Future.value([department07, department04]));
    when(inetFactory.lecturerProvider.getLecturers())
        .thenAnswer((_) => Future.value([lecturer03, lecturer05]));
    verifyZeroInteractions(inetFactory.campusProvider);
    verifyZeroInteractions(inetFactory.courseProvider);
    verifyZeroInteractions(inetFactory.departmentProvider);
    verifyZeroInteractions(inetFactory.lecturerProvider);
    var content = await controller.getContent();
    verify(inetFactory.departmentProvider.getDepartments()).called(1);
    verify(inetFactory.lecturerProvider.getLecturers()).called(1);
    verify(inetFactory.campusProvider.getCampuses()).called(1);
    verify(inetFactory.courseProvider.getCourses()).called(1);
    expect(content.lecturers, [lecturer03, lecturer05]);
    expect(content.departments, [department07, department04]);
    expect(content.campuses, [campus01, campus02, campus03]);
    expect(content.courses, [course01, course02]);
  });
}
