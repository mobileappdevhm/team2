import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/campus/mock/sqlite_campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_selection_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/sqlite_course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/selection_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/sqlite_department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/mock/mock_favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/mock/sqlite_lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_settings_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';

/// Provider factory producing mock providers.
class SqliteProviderFactory implements ProviderFactory {
  @override
  CourseProvider createCourseProvider() => new SqliteCourseProvider();

  @override
  DepartmentProvider createDepartmentProvider() =>
      new SqliteDepartmentProvider();

  @override
  LecturerProvider createLecturerProvider() => new SqliteLecturerProvider();

  @override
  SelectionProvider createSelectionProvider() => new MockSelectionProvider();

  @override
  UserProvider createUserProvider() => new MockUserProvider();

  @override
  FavoritesProvider createFavoritesProvider() => new MockFavoritesProvider();

  @override
  CampusProvider createCampusProvider() => new SqliteCampusProvider();

  @override
  UserSettingsProvider createSettingsProvider() =>
      new MockUserSettingsProvider();
}
