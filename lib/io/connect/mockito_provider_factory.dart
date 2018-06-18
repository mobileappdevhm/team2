import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';
import 'package:mockito/mockito.dart';

class MockitoProviderFactory implements ProviderFactory {
  MockitoCampusProvider campusProvider = new MockitoCampusProvider();
  MockitoCieProvider cieProvider = new MockitoCieProvider();
  MockitoCourseProvider courseProvider = new MockitoCourseProvider();
  MockitoDepartmentProvider departmentProvider =
      new MockitoDepartmentProvider();
  MockitoLecturerProvider lecturerProvider = new MockitoLecturerProvider();
  MockitoUserSettingsProvider userSettingsProvider =
      new MockitoUserSettingsProvider();
  MockitoUserProvider userProvider = new MockitoUserProvider();

  @override
  CampusProvider createCampusProvider() {
    return campusProvider;
  }

  @override
  CieProvider createCieProvider() {
    return cieProvider;
  }

  @override
  CourseProvider createCourseProvider() {
    return courseProvider;
  }

  @override
  DepartmentProvider createDepartmentProvider() {
    return departmentProvider;
  }

  @override
  LecturerProvider createLecturerProvider() {
    return lecturerProvider;
  }

  @override
  UserSettingsProvider createSettingsProvider() {
    return userSettingsProvider;
  }

  @override
  UserProvider createUserProvider() {
    return userProvider;
  }
}

class MockitoCampusProvider extends Mock implements CampusProvider {}

class MockitoCieProvider extends Mock implements CieProvider {}

class MockitoCourseProvider extends Mock implements CourseProvider {}

class MockitoDepartmentProvider extends Mock implements DepartmentProvider {}

class MockitoLecturerProvider extends Mock implements LecturerProvider {}

class MockitoUserSettingsProvider extends Mock implements UserSettingsProvider {
}

class MockitoUserProvider extends Mock implements UserProvider {}
