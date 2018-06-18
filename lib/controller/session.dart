import 'dart:async';

import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/connect/providers/campus_provider.dart';
import 'package:courses_in_english/io/connect/providers/course_provider.dart';
import 'package:courses_in_english/io/connect/providers/department_provider.dart';
import 'package:courses_in_english/io/connect/providers/lecturer_provider.dart';
import 'package:courses_in_english/io/connect/inet_provider_factory.dart';
import 'package:courses_in_english/io/connect/providers/user_provider.dart';
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
  List<Cie> _enteredCie = [];

  // Providers
  InetUserProvider _userProvider;
  InetCampusProvider _campusProvider;
  InetDepartmentProvider _departmentProvider;
  InetLecturerProvider _lecturerProvider;
  InetCourseProvider _courseProvider;
  CacheCieProvider _cieProvider;
  //UserSettingsProvider _settingsProvider;

  /// Call this to set up the data providers.
  /// In the prod code this should be called in main.dart.
  /// This method is useful for mocking the data providers in tests.
  void setUpProviders(InetProviderFactory inetProviderFactory, CacheProviderFactory cacheProviderFactory) {
    _userProvider = inetProviderFactory.createUserProvider();
    _campusProvider = inetProviderFactory.createCampusProvider();
    _departmentProvider = inetProviderFactory.createDepartmentProvider();
    _lecturerProvider = inetProviderFactory.createLecturerProvider();
    _courseProvider = inetProviderFactory.createCourseProvider();
    _cieProvider = cacheProviderFactory.createCieProvider();
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
    /* TODO repair this
    _enteredCie = await _cieProvider.getCies().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );*/
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

  Future<int> enterCie(Cie cie) async {
    // TODO use callback
    _enteredCie.add(cie);
    return _cieProvider.putCie(cie);
  }

  Future<int> removeCie(Cie cie) async {
    // TODO use callback
    _enteredCie.remove(cie);
    return _cieProvider.removeCie(cie);
  }

  void setSettings(UserSettings settings) {
    _settings = settings;
  }

  User get user => _user;

  Iterable<Campus> get campuses => _campuses;

  Iterable<Department> get departments => _departments;

  Iterable<Lecturer> get lecturers => _lecturers;

  Iterable<Course> get courses => _courses;

  Iterable<Course> get favorites => _favorites;

  Iterable<Course> get selected => _selected;

  UserSettings get settings => _settings;

  Iterable<Cie> get enteredCies => _enteredCie;
}
