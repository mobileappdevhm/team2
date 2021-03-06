import 'dart:async';
import 'dart:convert';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class ProdUserProvider implements InetUserProvider {
  final HttpHelper httpHelper;

  ProdUserProvider(this.httpHelper);

  @override
  Future<User> login(String username, String password) async {
    var token = await httpHelper.login(username, password);
    return httpHelper.getUserAsJson(token).then((raw) => json.decode(raw)).then(
        (map) => new User(map['id'], map['username'], map['firstName'],
            map['lastName'], null, token));
  }

  @override
  Future<bool> logout(User user) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> requestResetCode(String userMail) async {
    return httpHelper.requestResetCode(userMail);
  }

  @override
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword) async {
    return httpHelper.resetPassword(userMail, resetCode, newPassword);
  }
}
