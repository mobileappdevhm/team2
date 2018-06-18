import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/provider_factory.dart';
import 'package:courses_in_english/io/cache/sqlite_provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';

/// Where to get all data from!
class SqliteData {
  /// Singleton instance
  static final SqliteData _instance =
      new SqliteData._internal(new SqliteProviderFactory());

  CourseProvider courseProvider;
  DepartmentProvider departmentProvider;
  LecturerProvider lecturerProvider;
  UserProvider userProvider;
  CampusProvider campusProvider;
  UserSettingsProvider settingsProvider;

  /// Singleton factory
  factory SqliteData() {
    return _instance;
  }

  /// Private default constructor
  SqliteData._internal(ProviderFactory providerFactory)
      : courseProvider = providerFactory.createCourseProvider(),
        departmentProvider = providerFactory.createDepartmentProvider(),
        lecturerProvider = providerFactory.createLecturerProvider(),
        userProvider = providerFactory.createUserProvider(),
        campusProvider = providerFactory.createCampusProvider(),
        settingsProvider = providerFactory.createSettingsProvider();
}
