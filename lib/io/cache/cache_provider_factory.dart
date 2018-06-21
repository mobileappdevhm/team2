import 'package:courses_in_english/io/cache/providers/campus_provider.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/cache/providers/course_provider.dart';
import 'package:courses_in_english/io/cache/providers/custom_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/cache/providers/department_provider.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_provider.dart';
import 'package:courses_in_english/io/cache/providers/user_settings_provider.dart';

abstract class CacheProviderFactory {
  CacheCampusProvider createCampusProvider();
  CacheCieProvider createCieProvider();
  CacheCourseProvider createCourseProvider();
  CacheSelectedCourseProvider createSelectedCourseProvider();
  CacheCustomCourseProvider createCustomCourseProvider();
  CacheDepartmentProvider createDepartmentProvider();
  CacheLecturerProvider createLecturerProvider();
  CacheUserProvider createCacheUserProvider();
  CacheUserSettingsProvider createSettingsProvider();
}
