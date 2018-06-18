import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_lecturer_provider.dart';
import 'package:courses_in_english/io/connect/provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_user_provider.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_user_settings_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';

/// Provider factory producing mock providers.
class MockProviderFactory implements ProviderFactory {
  @override
  CourseProvider createCourseProvider() => new MockCourseProvider();

  @override
  DepartmentProvider createDepartmentProvider() => new MockDepartmentProvider();

  @override
  LecturerProvider createLecturerProvider() => new MockLecturerProvider();

  @override
  UserProvider createUserProvider() => new MockUserProvider();

  @override
  CampusProvider createCampusProvider() => new MockCampusProvider();

  @override
  UserSettingsProvider createSettingsProvider() =>
      new MockUserSettingsProvider();

  @override
  CieProvider createCieProvider() {
    return new MockCieProvider();
  }
}
