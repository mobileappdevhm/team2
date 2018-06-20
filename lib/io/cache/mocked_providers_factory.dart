import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';
import 'package:mockito/mockito.dart';

class MockedCacheProvidersFactory implements CacheProviderFactory {
  final MockitoCacheUserProvider cacheUserProvider = MockitoCacheUserProvider();
  final MockitoCacheCampusProvider cacheCampusProvider =
      MockitoCacheCampusProvider();
  final MockitoCacheCieProvider cacheCieProvider = MockitoCacheCieProvider();
  final MockitoCacheCourseProvider cacheCourseProvider =
      MockitoCacheCourseProvider();
  final MockitoCacheCustomCourseProvider cacheCustomCourseProvider =
      MockitoCacheCustomCourseProvider();
  final MockitoCacheDepartmentProvider cacheDepartmentProvider =
      MockitoCacheDepartmentProvider();
  final MockitoCacheLecturerProvider cacheLecturerProvider =
      MockitoCacheLecturerProvider();
  final MockitoCacheUserSettingsProvider cacheUserSettingsProvider =
      MockitoCacheUserSettingsProvider();

  @override
  CacheUserProvider createCacheUserProvider() => cacheUserProvider;

  @override
  CacheCampusProvider createCampusProvider() => cacheCampusProvider;

  @override
  CacheCieProvider createCieProvider() => cacheCieProvider;

  @override
  CacheCourseProvider createCourseProvider() => cacheCourseProvider;

  @override
  CacheCustomCourseProvider createCustomCourseProvider() =>
      cacheCustomCourseProvider;

  @override
  CacheDepartmentProvider createDepartmentProvider() => cacheDepartmentProvider;

  @override
  CacheLecturerProvider createLecturerProvider() => cacheLecturerProvider;

  @override
  CacheUserSettingsProvider createSettingsProvider() =>
      cacheUserSettingsProvider;
}

class MockitoCacheUserProvider extends Mock implements CacheUserProvider {}

class MockitoCacheCampusProvider extends Mock implements CacheCampusProvider {}

class MockitoCacheCieProvider extends Mock implements CacheCieProvider {}

class MockitoCacheCourseProvider extends Mock implements CacheCourseProvider {}

class MockitoCacheCustomCourseProvider extends Mock
    implements CacheCustomCourseProvider {}

class MockitoCacheDepartmentProvider extends Mock
    implements CacheDepartmentProvider {}

class MockitoCacheLecturerProvider extends Mock
    implements CacheLecturerProvider {}

class MockitoCacheUserSettingsProvider extends Mock
    implements CacheUserSettingsProvider {}
