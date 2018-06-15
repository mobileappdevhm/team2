import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/campus/sqlite_campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/cie/cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/cie/mock/sqlite_cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/sqlite_course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/sqlite_department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/sqlite_user_settings_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';

/// Provider factory producing mock providers.
class SqliteProviderFactory implements ProviderFactory {
  @override
  CourseProvider createCourseProvider() => new SqliteCourseProvider();

  @override
  DepartmentProvider createDepartmentProvider() =>
      new SqliteDepartmentProvider();

  @override
  LecturerProvider createLecturerProvider() => new SqliteLecturerProvider();

  @override
  UserProvider createUserProvider() => new MockUserProvider();

  @override
  CampusProvider createCampusProvider() => new SqliteCampusProvider();

  @override
  UserSettingsProvider createSettingsProvider() =>
      new SqliteUserSettingsProvider();

  @override
  CieProvider createCieProvider() {
    return new SqliteCieProvider();
  }
}
