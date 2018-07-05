import 'dart:async';

import 'package:courses_in_english/model/course/course.dart';

abstract class HttpHelper {
  /// Returns webtoken
  Future<String> login(String email, String password);
  Future<String> getUserAsJson(String token);
  Future<String> getDepartmentsAsJson();
  Future<String> getCampusesAsJson();
  Future<String> getCoursesAsJson();
  Future<String> getLecturersAsJson();
  Future<String> getLocationsAsJson();
  Future<bool> requestResetCode(String userMail);
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword);
  void pushFavorites(List<Course> courses, String token);
}
