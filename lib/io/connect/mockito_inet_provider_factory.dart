import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/inet_provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:mockito/mockito.dart';

class MockitoProviderFactory implements InetProviderFactory {
  MockitoInetCampusProvider campusProvider = new MockitoInetCampusProvider();
  MockitoInetCourseProvider courseProvider = new MockitoInetCourseProvider();
  MockitoInetDepartmentProvider departmentProvider =
      new MockitoInetDepartmentProvider();
  MockitoInetLecturerProvider lecturerProvider = new MockitoInetLecturerProvider();
  MockitoInetUserProvider userProvider = new MockitoInetUserProvider();

  @override
  InetCampusProvider createCampusProvider() {
    return campusProvider;
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
  InetUserProvider createUserProvider() {
    return userProvider;
  }
}

class MockitoInetCampusProvider extends Mock implements InetCampusProvider {}

class MockitoInetCourseProvider extends Mock implements InetCourseProvider {}

class MockitoInetDepartmentProvider extends Mock implements InetDepartmentProvider {}

class MockitoInetLecturerProvider extends Mock implements InetLecturerProvider {}

class MockitoInetUserProvider extends Mock implements InetUserProvider {}
