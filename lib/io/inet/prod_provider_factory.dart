import 'package:courses_in_english/io/inet/http/prod_http_helper.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
import 'package:courses_in_english/io/inet/providers/campus_provider.dart';
import 'package:courses_in_english/io/inet/providers/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/department_provider.dart';
import 'package:courses_in_english/io/inet/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/inet/providers/mock/mock_campus_provider.dart';
import 'package:courses_in_english/io/inet/providers/prod/course_provider.dart';
import 'package:courses_in_english/io/inet/providers/prod/department_provider.dart';
import 'package:courses_in_english/io/inet/providers/prod/lecturer_provider.dart';
import 'package:courses_in_english/io/inet/providers/prod/user_provider.dart';
import 'package:courses_in_english/io/inet/providers/selected_course_provider.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';

//import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';

/// Provider factory producing mock providers.
class ProviderFactory implements InetProviderFactory {
  ProdHttpHelper httpHelper = new ProdHttpHelper();

  @override
  InetCourseProvider createCourseProvider() =>
      new ProdCourseProvider(httpHelper);

  @override
  InetDepartmentProvider createDepartmentProvider() =>
      new ProdDepartmentProvider(httpHelper);

  @override
  InetLecturerProvider createLecturerProvider() =>
      new ProdLecturerProvider(httpHelper);

  @override
  InetUserProvider createUserProvider() => new ProdUserProvider(httpHelper);

  @override
  InetCampusProvider createCampusProvider() => new MockInetCampusProvider();

  @override
  InetSelectedCourseProvider createSelectedCourseProvider() => null; // TODO
}
