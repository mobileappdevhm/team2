import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

abstract class CacheProviderFactory {
  CacheCampusProvider createCampusProvider();
  CacheCieProvider createCieProvider();
  CacheCourseProvider createCourseProvider();
  CacheCustomCourseProvider createCustomCourseProvider();
  CacheDepartmentProvider createDepartmentProvider();
  CacheLecturerProvider createLecturerProvider();
  CacheUserProvider createCacheUserProvider();
  CacheUserSettingsProvider createSettingsProvider();
}
