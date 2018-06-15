import 'package:courses_in_english/connect/dataprovider/data.dart';
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

  final Data data = new Data();
  final List<OnDataChanged> callbacks = [];

  User _user;

  // This is bad form, I know, however otherwise the tests won't work
  UserSettings _settings = new UserSettings();
  Iterable<Campus> _campuses;
  Iterable<Department> _departments;
  Iterable<Lecturer> _lecturers;
  Iterable<Course> _courses;
  Iterable<Course> _favorites;
  Iterable<Course> _selected;
  Iterable<Cie> _enteredCie;

  void login(
    String email,
    String password, {
    OnSuccess success,
    OnFailure failure,
  }) async {
    await data.userProvider.login(email, password).then(
      (user) {
        _user = user;
        // TODO save user to cache
        success(this);
      },
      onError: (Error e) => failure(this, e),
    );
    try {
      data.settingsProvider.getCurrentSettings().then(
        _settings = settings
      );
    } catch (e){
    }
  }

  void download({OnFailure failure}) async {
    bool successful = true;
    _campuses = await data.campusProvider.getCampuses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _departments = await data.departmentProvider.getDepartments().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _lecturers = await data.lecturerProvider.getLecturers().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _courses = await data.courseProvider.getCourses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _favorites = await data.courseProvider.getFavorizedCourses().catchError(
      (error) {
        successful = false;
        if (failure != null) failure(this, error);
      },
    );
    _selected = await data.courseProvider.getSelectedCourses().catchError(
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
    _favorites = await data.courseProvider.favorizeCourse(c).then((_) {
      return data.courseProvider.getFavorizedCourses();
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
    _favorites = await data.courseProvider.unFavorizeCourse(c).then((_) {
      return data.courseProvider.getFavorizedCourses();
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
    data.cieProvider.putCie(cie);
  }

  void removeCie(Cie cie) {
    data.cieProvider.removeCie(cie);
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
