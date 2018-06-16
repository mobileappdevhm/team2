import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/cie/cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:mockito/mockito.dart';

class MockitoProviderFactory implements ProviderFactory {

  MockitoCampusProvider campusProvider = new MockitoCampusProvider();
  MockitoCieProvider cieProvider = new MockitoCieProvider();
  MockitoCourseProvider courseProvider = new MockitoCourseProvider();
  MockitoDepartmentProvider departmentProvider = new MockitoDepartmentProvider();
  MockitoLecturerProvider lecturerProvider = new MockitoLecturerProvider();
  MockitoUserSettingsProvider userSettingsProvider = new MockitoUserSettingsProvider();
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
class MockitoUserSettingsProvider extends Mock implements UserSettingsProvider {}
class MockitoUserProvider extends Mock implements UserProvider {}