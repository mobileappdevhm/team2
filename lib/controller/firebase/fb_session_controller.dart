import 'dart:async';

import 'package:courses_in_english/controller/firebase/firebase_controller.dart';
import 'package:courses_in_english/controller/session_controller.dart';
import 'package:courses_in_english/model/user/user.dart';

class FbSessionController implements SessionController {
  final SessionController controller;
  final FirebaseController firebaseController;

  FbSessionController(this.firebaseController, this.controller);

  bool get isLoggedIn => controller.isLoggedIn;

  User get user => controller.user;

  Future<User> login(String email, String password) async {
    return controller.login(email, password).then((user) {
      firebaseController.logLogin();
      if (user != null) {
        firebaseController.logUserParameter(
            name: "department", value: user.department.toString());
      }
      return user;
    });
  }

  @override
  Future<bool> requestPasswordReset(String userMail) {
    return controller.requestPasswordReset(userMail);
  }

  @override
  Future<bool> resetPassword(
      String userMail, String resetCode, String newPassword) {
    return controller.resetPassword(userMail, resetCode, newPassword);
  }

  @override
  void logout() {
    return controller.logout();
  }
}
