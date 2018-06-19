import 'dart:async';

import 'package:courses_in_english/io/cache/cache_provider_factory.dart';
import 'package:courses_in_english/io/cache/data_access/prod_databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/cie_provider.dart';
import 'package:courses_in_english/io/inet/inet_provider_factory.dart';
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
  CacheCieProvider _cieProvider;
  //UserSettingsProvider _settingsProvider;

  /// Call this to set up the data providers.
  /// In the prod code this should be called in main.dart.
  /// This method is useful for mocking the data providers in tests.
  void setUpProviders(InetProviderFactory inetProviderFactory,
      CacheProviderFactory cacheProviderFactory) {
    _cieProvider = cacheProviderFactory.createCieProvider();
    //_settingsProvider = providerFactory.createSettingsProvider();
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
    return _cieProvider.putCie(cie, user);
  }

  Future<int> removeCie(Cie cie) async {
    // TODO use callback
    _enteredCie.remove(cie);
    return _cieProvider.removeCie(cie);
  }

  void setSettings(UserSettings settings) {
    _settings = settings;
  }

  void resetApp() {
    ProdDatabaseHelper dbh = new ProdDatabaseHelper();
    dbh.truncateAllTable();
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
