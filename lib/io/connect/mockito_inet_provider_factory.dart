import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/inet_provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';
import 'package:mockito/mockito.dart';

class MockitoProviderFactory implements InetProviderFactory {
  MockitoInetCampusProvider campusProvider = new MockitoInetCampusProvider();
  MockitoInetCieProvider cieProvider = new MockitoInetCieProvider();
  MockitoInetCourseProvider courseProvider = new MockitoInetCourseProvider();
  MockitoInetDepartmentProvider departmentProvider =
      new MockitoInetDepartmentProvider();
  MockitoInetLecturerProvider lecturerProvider = new MockitoInetLecturerProvider();
  MockitoInetUserSettingsProvider userSettingsProvider =
      new MockitoInetUserSettingsProvider();
  MockitoInetUserProvider userProvider = new MockitoInetUserProvider();

  @override
  InetCampusProvider createCampusProvider() {
    return campusProvider;
  }

  @override
  InetCieProvider createCieProvider() {
    return cieProvider;
  }

  @override
  InetCourseProvider createCourseProvider() {
    return courseProvider;
  }

  @override
  InetDepartmentProvider createDepartmentProvider() {
    return departmentProvider;
  }

  @override
  InetLecturerProvider createLecturerProvider() {
    return lecturerProvider;
  }

  @override
  InetUserSettingsProvider createSettingsProvider() {
    return userSettingsProvider;
  }

  @override
  InetUserProvider createUserProvider() {
    return userProvider;
  }
}

class MockitoInetCampusProvider extends Mock implements InetCampusProvider {}

class MockitoInetCieProvider extends Mock implements InetCieProvider {}

class MockitoInetCourseProvider extends Mock implements InetCourseProvider {}

class MockitoInetDepartmentProvider extends Mock implements InetDepartmentProvider {}

class MockitoInetLecturerProvider extends Mock implements InetLecturerProvider {}

class MockitoInetUserSettingsProvider extends Mock implements InetUserSettingsProvider {
}

class MockitoInetUserProvider extends Mock implements InetUserProvider {}
