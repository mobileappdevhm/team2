import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/data_access/mockito_databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_department_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/sqlite/sqlite_user_settings_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

class MockedDataBaseHelperFactory implements CacheProviderFactory {
  final MockitoDatabaseHelper dbh = new MockitoDatabaseHelper();

  // TODO ffs add a user provider for caching
  @override
  CacheUserProvider createCacheUserProvider() => throw new UnimplementedError();

  @override
  CacheCampusProvider createCampusProvider() => new SqliteCampusProvider(dbh);

  @override
  CacheCieProvider createCieProvider() => new SqliteCieProvider(dbh);

  @override
  CacheCourseProvider createCourseProvider() => new SqliteCourseProvider(dbh);

  @override
  CacheCustomCourseProvider createCustomCourseProvider() =>
      new SqliteCustomCourseProvider(dbh);

  @override
  CacheDepartmentProvider createDepartmentProvider() =>
      new SqliteDepartmentProvider(dbh);

  @override
  CacheLecturerProvider createLecturerProvider() =>
      new SqliteLecturerProvider(dbh);

  @override
  CacheUserSettingsProvider createSettingsProvider() =>
      new SqliteUserSettingsProvider(dbh);
}
