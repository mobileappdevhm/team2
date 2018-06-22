import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/prod/department_provider.dart';
import 'package:courses_in_english/io/inet/providers/prod/lecturer_provider.dart';
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

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    var response = await client.post(
      url,
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> get(String url, [String token]) async {
    var response = token == null
        ? await client.get(url)
        : await client.get(url, headers: {'Authorization': 'Bearer $token'});
    return json.decode(response.body);
  }

  Future<List<dynamic>> getList(String url, [String token]) async {
    var response = token == null
        ? await client.get(url)
        : await client.get(url, headers: {'Authorization': 'Bearer $token'});
    return json.decode(response.body, reviver: (k, v) {
      if (k == 'lecturer') return ProdLecturerProvider.parseLecturer(v);
      if (k == 'department') return ProdDepartmentProvider.parseDepartment(v);
      if (k == 'location') return null;
      return v;
    });
  }

  @override
  Future<List<dynamic>> getCourses() => getList(baseUrl + '/courses');

  @override
  Future<List<dynamic>> getDepartments() => getList(baseUrl + '/departments');

  @override
  Future<List<dynamic>> getLecturers() => getList(baseUrl + '/lecturers');

  @override
  Future<List<dynamic>> getLocations() {
    throw new UnimplementedError();
  }

  @override
  Future<List<dynamic>> getCampuses() {
    throw new UnimplementedError();
  }

  @override
  Future<bool> requestResetCode(String userMail) async{
    bool success;
    await client.get(baseUrl + "/users/reset-password/" + userMail).then((response){
      success = (response.statusCode == 200);
    });
    return success;
  }

  @override
  Future<bool> resetPassword(String userMail, String resetCode, String newPassword) async{
    bool success;
    await client.get(baseUrl + "/users/reset-password/" + userMail + "/" + resetCode + "/" + newPassword).then((response){
      success = (response.statusCode == 200);
    });
    return success;
  }
}
