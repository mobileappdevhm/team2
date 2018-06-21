import 'package:courses_in_english/io/inet/providers/campus_provider.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_campus_provider.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_course_provider.dart';
import 'package:courses_in_english/io/inet/providers/department_provider.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_department_provider.dart';
import 'package:courses_in_english/io/inet/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_lecturer_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_user_provider.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';

/// Provider factory producing mock providers.
class MockProviderFactory implements InetProviderFactory {
  @override
  InetCourseProvider createCourseProvider() => new MockInetCourseProvider();

  @override
  InetDepartmentProvider createDepartmentProvider() =>
      new MockInetDepartmentProvider();

  @override
  InetLecturerProvider createLecturerProvider() =>
      new MockInetLecturerProvider();

  @override
  InetUserProvider createUserProvider() => new MockInetUserProvider();

  @override
  InetCampusProvider createCampusProvider() => new MockInetCampusProvider();

  @override
  InetSelectedCourseProvider createSelectedCourseProvider() =>
      throw new UnimplementedError();
}
