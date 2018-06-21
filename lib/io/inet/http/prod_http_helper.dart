import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:http/http.dart' as http;

class ProdHttpHelper implements HttpHelper {
  static const String baseUrl = 'http://cie.cs.hm.edu:25889/api';
  final client = new http.Client();

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    return post(
        baseUrl + '/auth/signin', {'email': email, 'password': password});
  }

  @override
  Future<Map<String, dynamic>> getUser(String token) {
    return get(baseUrl + '/users/current', token);
  }

  dynamic post(String url, Map<String, dynamic> body) async {
    var response = await client.post(
      url,
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return json.decode(response.body);
  }

  dynamic get(String url, [String token]) async {
    var response = token == null
        ? await client.get(url)
        : await client.get(url, headers: {'Authorization': 'Bearer $token'});
    return json.decode(response.body);
  }

  @override
  Future<List<Map<String, dynamic>>> getCourses() => get('/courses');

  @override
  Future<List<Map<String, dynamic>>> getDepartments() => get('/departments');

  @override
  Future<List<Map<String, dynamic>>> getLecturers() => get('/lecturers');

  @override
  Future<List<Map<String, dynamic>>> getLocations() {
    throw new UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getCampuses() {
    throw new UnimplementedError();
  }
}
