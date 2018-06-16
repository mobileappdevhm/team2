import 'package:courses_in_english/connect/dataprovider/campus/campus_provider.dart';
import 'package:courses_in_english/connect/dataprovider/cie/cie_provider.dart';
import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/connect/dataprovider/department/department_provider.dart';
import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/connect/dataprovider/provider_factory.dart';
import 'package:courses_in_english/connect/dataprovider/user/user_provider.dart';
//import 'package:courses_in_english/connect/dataprovider/user/user_settings_provider.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/model/user/user.dart';
import 'package:courses_in_english/model/user/user_settings.dart';

typedef void OnSuccess(Session s);
typedef void OnDataChanged(Session s);
typedef void OnFailure(Session s, Error e);

class Session {
  // Singleton
  static final _instance = new Session._internal();

  factory Session() => _instance;

  Session._internal();

  final List<OnDataChanged> callbacks = [];

  User _user;

  // This is bad form, I know, however otherwise the tests won't work
  UserSettings _settings;
  Iterable<Campus> _campuses = [];
  Iterable<Department> _departments = [];
  Iterable<Lecturer> _lecturers = [];
  Iterable<Course> _courses = [];
  Iterable<Course> _favorites = [];
  Iterable<Course> _selected = [];
  Iterable<Cie> _enteredCie = [];

  // Providers
  UserProvider _userProvider;
  CampusProvider _campusProvider;
  DepartmentProvider _departmentProvider;
  LecturerProvider _lecturerProvider;
  CourseProvider _courseProvider;
  CieProvider _cieProvider;
  //UserSettingsProvider _settingsProvider;

  /// Call this to set up the data providers.
  /// In the prod code this should be called in main.dart.
  /// This method is useful for mocking the data providers in tests.
  void setUpProviders(ProviderFactory providerFactory) {
    _userProvider = providerFactory.createUserProvider();
    _campusProvider = providerFactory.createCampusProvider();
    _departmentProvider = providerFactory.createDepartmentProvider();
    _lecturerProvider = providerFactory.createLecturerProvider();
    _courseProvider = providerFactory.createCourseProvider();
    _cieProvider = providerFactory.createCieProvider();
    //_settingsProvider = providerFactory.createSettingsProvider();
  }

  void login(String email, String password,
      {OnSuccess success, OnFailure failure}) async {
    await _userProvider.login(email, password).then(
      (user) {
        _user = user;
        // TODO save user to cache
        if (success != null) success(this);
      },
      onError: (e) {
        if (failure != null) failure(this, e);
      },
    );
    // TODO This doesnt work yet
    // _settingsProvider.getCurrentSettings().then(_settings = settings);
  }

  void download({OnFailure failure}) async {
    bool successful = true;
    _campuses = await _campusProvider.getCampuses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _departments = await _departmentProvider.getDepartments().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _lecturers = await _lecturerProvider.getLecturers().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _courses = await _courseProvider.getCourses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _favorites = await _courseProvider.getFavorizedCourses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _selected = await _courseProvider.getSelectedCourses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    if (successful) {
      // TODO save downloaded data to cache
      callbacks.forEach((callback) => callback(this));
    }
  }

  void favorize(Course c, {OnSuccess success, OnFailure failure}) async {
    bool successful = true;
    _favorites = await _courseProvider.favorizeCourse(c).then((_) {
      return _courseProvider.getFavorizedCourses();
    }).catchError((error) {
      successful = false;
      if (failure != null) failure(this, error);
    }).whenComplete(() {
      if (success != null) success(this);
    });
    if (successful) callbacks.forEach((callback) => callback(this));
  }

  void unfavorize(Course c, {OnSuccess success, OnFailure failure}) async {
    bool successful = true;
    _favorites = await _courseProvider.unFavorizeCourse(c).then((_) {
      return _courseProvider.getFavorizedCourses();
    }).catchError((error) {
      successful = false;
      if (failure != null) failure(this, error);
    }).whenComplete(() {
      if (success != null) success(this);
    });
    if (successful) callbacks.forEach((callback) => callback(this));
  }

  void select(Course c, {OnSuccess success, OnFailure failure}) async {
    // TODO to be implemented
    throw new UnimplementedError();
  }

  void deselect(Course c, {OnSuccess success, OnFailure failure}) async {
    // TODO to be implemented
    throw new UnimplementedError();
  }

  void enterCie(Cie cie) {
    _cieProvider.putCie(cie);
  }

  void removeCie(Cie cie) {
    _cieProvider.removeCie(cie);
  }

  void setSettings(UserSettings settings) {
    _settings = settings;
  }

  get user => _user;

  get campuses => _campuses;

  get departments => _departments;

  get lecturers => _lecturers;

  get courses => _courses;

  get favorites => _favorites;

  get selected => _selected;

  get settings => _settings;

  get enteredCies => _enteredCie;
}
