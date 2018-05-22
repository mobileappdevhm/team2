import 'package:courses_in_english/connect/dataprovider/course/mock/mock_course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_selection_provider.dart';
import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/department/mock/mock_department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/mock/mock_favorites_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/mock/mock_lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/mock/mock_user_provider.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:test/test.dart';

void main() {

  Data _data;

  /**
   * Set up our data source, as we know it from java tests
   */
  setUp(() {
    _data = new Data();
  });

  /**
   * Sadly, we cannot test the Factory overall, so that's why we need all the imports.
   */
  test('Mock Factory Test', () {
    /// As Classes are not really types in Dart, we can only test instances using the wrapper
    expect(_data.courseProvider, new isInstanceOf<MockCourseProvider>());
    expect(_data.lecturerProvider, new isInstanceOf<MockLecturerProvider>());
    expect(_data.departmentProvider, new isInstanceOf<MockDepartmentProvider>());
    expect(_data.favoritesProvider, new isInstanceOf<MockFavoritesProvider>());
    expect(_data.selectionProvider, new isInstanceOf<MockSelectionProvider>());
    expect(_data.userProvider, new isInstanceOf<MockUserProvider>());
  });

  test('User Provider Test', () {
    UserProvider userProvider = new MockUserProvider();
    User test;
    userProvider.login('Woop', 'Badopop').then((User value){
      test = value;
    });
    expect(test, equals(new User(-1, "", "", "", 7)));
  });



}