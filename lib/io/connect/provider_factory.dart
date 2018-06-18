import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_settings_provider.dart';

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

  /// Create new instance of a campus provider.
  CampusProvider createCampusProvider();

  /// Create a new instance of the settings provider.
  UserSettingsProvider createSettingsProvider();

  /// Create the Cie Provider
  CieProvider createCieProvider();
}
