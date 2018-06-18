import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_department_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/prod/sqlite_user_settings_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

/// Provider factory producing mock providers.
class SqliteProviderFactory implements CacheProviderFactory {

  // TODO User cache?
  @override
  CacheUserProvider createCacheUserProvider() => throw new UnimplementedError("There is no user cache yet!");

  @override
  CacheCampusProvider createCampusProvider() => new SqliteCampusProvider();

  @override
  CacheCieProvider createCieProvider() => new SqliteCieProvider();

  @override
  CacheCourseProvider createCourseProvider() => new SqliteCourseProvider();

  @override
  CacheCustomCourseProvider createCustomCourseProvider() => new SqliteCustomCourseProvider();

  @override
  CacheDepartmentProvider createDepartmentProvider() => new SqliteDepartmentProvider();

  @override
  CacheLecturerProvider createLecturerProvider() => new SqliteLecturerProvider();

  @override
  CacheUserSettingsProvider createSettingsProvider() => new SqliteUserSettingsProvider();
}
