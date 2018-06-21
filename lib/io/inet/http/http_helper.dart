import 'dart:async';

abstract class HttpHelper {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> getUser(String token);
  Future<List<Map<String, dynamic>>> getDepartments();
  Future<List<Map<String, dynamic>>> getCourses();
  Future<List<Map<String, dynamic>>> getLecturers();
  Future<List<Map<String, dynamic>>> getLocations();
}