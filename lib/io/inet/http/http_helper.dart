import 'dart:async';

abstract class HttpHelper {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> getUser(String token);
  Future<List<dynamic>> getDepartments();
  Future<List<dynamic>> getCourses();
  Future<List<dynamic>> getLecturers();
  Future<List<dynamic>> getLocations();
  Future<List<dynamic>> getCampuses();
}
