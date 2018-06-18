import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';

/// Factory for all internet providers.
abstract class InetProviderFactory {
  /// Create new instance of a course provider.
  InetCourseProvider createCourseProvider();

  /// Create new instance of an user provider.
  InetUserProvider createUserProvider();

  /// Create new instance of an lecturer provider.
  InetLecturerProvider createLecturerProvider();

  /// Create new instance of a department provider.
  InetDepartmentProvider createDepartmentProvider();

  /// Create new instance of a campus provider.
  InetCampusProvider createCampusProvider();
}
