import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/campus/mock/mock_campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_selection_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/selection_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/mock/mock_department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/mock/mock_favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/mock/mock_lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';

/// Provider factory producing mock providers.
class MockProviderFactory implements ProviderFactory {
  @override
  CourseProvider createCourseProvider() => new MockCourseProvider();

  @override
  DepartmentProvider createDepartmentProvider() => new MockDepartmentProvider();

  @override
  LecturerProvider createLecturerProvider() => new MockLecturerProvider();

  @override
  SelectionProvider createSelectionProvider() => new MockSelectionProvider();

  @override
  UserProvider createUserProvider() => new MockUserProvider();

  @override
  FavoritesProvider createFavoritesProvider() => new MockFavoritesProvider();

  @override
  CampusProvider createCampusProvider() => new MockCampusProvider();

  @override
  UserSettingsProvider createSettingsProvider() =>
      new MockUserSettingsProvider();
}
