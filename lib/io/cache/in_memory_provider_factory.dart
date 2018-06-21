import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_department_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_user_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_user_settings_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

class InMemoryProviderFactory implements CacheProviderFactory {
  @override
  CacheUserProvider createCacheUserProvider() => new InMemoryUserProvider();

  @override
  CacheCampusProvider createCampusProvider() => new InMemoryCampusProvider();

  @override
  CacheCieProvider createCieProvider() => new InMemoryCieProvider();

  @override
  CacheCourseProvider createCourseProvider() => new InMemoryCourseProvider();

  @override
  CacheCustomCourseProvider createCustomCourseProvider() =>
      new InMemoryCustomCourseProvider();

  @override
  CacheDepartmentProvider createDepartmentProvider() =>
      new InMemoryDepartmentProvider();

  @override
  CacheLecturerProvider createLecturerProvider() =>
      new InMemoryLecturerProvider();

  @override
  CacheUserSettingsProvider createSettingsProvider() =>
      new InMemoryUserSettingsProvider();

  @override
  CacheSelectedCourseProvider createSelectedCourseProvider() =>
      throw new UnimplementedError();
}
