import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';

/// Factory for all providers.
abstract class ProviderFactory {
  /// Create new instance of a course provider.
  CourseProvider createCourseProvider();

  /// Create new instance of an user provider.
  UserProvider createUserProvider();

  /// Create new instance of an lecturer provider.
  LecturerProvider createLecturerProvider();

  /// Create new instance of a department provider.
  DepartmentProvider createDepartmentProvider();

  /// Create new instance of a favorites provider.
  FavoritesProvider createFavoritesProvider();

  /// Create new instance of a campus provider.
  CampusProvider createCampusProvider();

  /// Create a new instance of the settings provider.
  UserSettingsProvider createSettingsProvider();
}
