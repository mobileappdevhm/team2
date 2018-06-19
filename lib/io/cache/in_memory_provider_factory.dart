import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/in_memory/inmem_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

class InMemoryProviderFactory implements CacheProviderFactory {
  @override
  CacheUserProvider createCacheUserProvider() => throw new UnimplementedError();

  @override
  CacheCampusProvider createCampusProvider() => throw new UnimplementedError();

  @override
  CacheCieProvider createCieProvider() => throw new UnimplementedError();

  @override
  CacheCourseProvider createCourseProvider() => new InMemoryCourseProvider();

  @override
  CacheCustomCourseProvider createCustomCourseProvider() =>
      throw new UnimplementedError();

  @override
  CacheDepartmentProvider createDepartmentProvider() =>
      throw new UnimplementedError();

  @override
  CacheLecturerProvider createLecturerProvider() =>
      throw new UnimplementedError();

  @override
  CacheUserSettingsProvider createSettingsProvider() =>
      throw new UnimplementedError();
}
