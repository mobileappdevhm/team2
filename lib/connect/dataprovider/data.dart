import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/cie/cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/mock_provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';

/// Where to get all data from!
class Data {
  /// Singleton instance
  static final Data _instance = new Data._internal(new MockProviderFactory());

  CourseProvider courseProvider;
  DepartmentProvider departmentProvider;
  LecturerProvider lecturerProvider;
  UserProvider userProvider;
  CampusProvider campusProvider;
  UserSettingsProvider settingsProvider;
  CieProvider cieProvider;

  /// Singleton factory
  factory Data() {
    return _instance;
  }

  /// Private default constructor
  Data._internal(ProviderFactory providerFactory)
      : courseProvider = providerFactory.createCourseProvider(),
        departmentProvider = providerFactory.createDepartmentProvider(),
        lecturerProvider = providerFactory.createLecturerProvider(),
        userProvider = providerFactory.createUserProvider(),
        campusProvider = providerFactory.createCampusProvider(),
        settingsProvider = providerFactory.createSettingsProvider(),
        cieProvider = providerFactory.createCieProvider();
}
