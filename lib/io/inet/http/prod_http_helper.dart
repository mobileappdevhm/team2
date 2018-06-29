import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:http/http.dart' as http;

class ProdHttpHelper implements HttpHelper {
  static const String baseUrl = 'http://cie.cs.hm.edu:25889/api';
  final client = new http.Client();

  @override
  Future<bool> requestResetCode(String userMail) async {
    bool success;
    await client
        .get(baseUrl + "/users/reset-password/" + userMail)
        .then((response) {
      success = (response.statusCode == 200);
    });
    return success;
  }

  @override
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword) async {
    bool success;
    await client
        .get(baseUrl +
            "/users/reset-password/" +
            userMail +
            "/" +
            resetCode +
            "/" +
            newPassword)
        .then((response) {
      success = (response.statusCode == 200);
    });
    return success;
  }

  @override
  Future<String> getCoursesAsJson() async =>
      _get('/courses').then((response) => response.body);

  @override
  Future<String> getDepartmentsAsJson() async =>
      _get('/departments').then((response) => response.body);

  @override
  Future<String> getLecturersAsJson() async =>
      _get('/lecturers').then((response) => response.body);

  @override
  Future<String> getLocationsAsJson() async =>
      _get('/locations').then((response) => response.body);

  @override
  Future<String> getUserAsJson(String token) async =>
      _get('/users/current', token: token).then((response) => response.body);

  @override
  Future<String> login(String email, String password) async =>
      _post('/auth/signin/', {
        'email': email,
        'password': password,
      }).then((response) => json.decode(response.body)['accessToken']);

  Future<http.Response> _get(String resource, {String token = ''}) async {
    var response = await client.get(baseUrl + resource, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw new Exception('Http status: ${response.statusCode}');
    }
    return response;
  }

  Future<http.Response> _post(String resource, Object body,
      {String token = ''}) async {
    var response = await client.post(
      baseUrl + resource,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw new Exception('Http status: ${response.statusCode}');
    }
    return response;
  }
}
