import 'dart:async';

import 'package:courses_in_english/io/inet/http/http_helper.dart';
import 'package:courses_in_english/io/inet/providers/user_provider.dart';
import 'package:courses_in_english/model/user/user.dart';

class ProdUserProvider implements InetUserProvider {
  final HttpHelper httpHelper;

  ProdUserProvider(this.httpHelper);

  @override
  Future<User> login(String username, String password) async {
    var loginResult = await httpHelper.login(username, password);
    return httpHelper.getUser(loginResult['accessToken']).then((map) =>
        new User(map['id'], map['username'], map['firstName'], map['lastName'],
            null, loginResult['accessToken']));
  }

  @override
  Future<bool> logout(User user) {
    throw new UnimplementedError();
  }

  @override
  Future<bool> requestResetCode(String userMail) async {
    return httpHelper.requestResetCode(userMail);
  }
}
