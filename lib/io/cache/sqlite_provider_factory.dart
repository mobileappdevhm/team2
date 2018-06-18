import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/campus/sqlite_campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/cie/sqlite_cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/course/sqlite_course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/department/sqlite_department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/lecturer/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/io/connect/provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/mock/mock_user_provider.dart';
import 'package:courses_in_english/io/cache/user/sqlite_user_settings_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';

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
