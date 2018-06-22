import 'dart:async';

import 'package:courses_in_english/controller/cie_controller.dart';
import 'package:courses_in_english/controller/firebase/firebase_controller.dart';
import 'package:courses_in_english/model/cie/cie.dart';
import 'package:courses_in_english/model/user/user.dart';

class FbCieController implements CieController {
  final FirebaseController firebaseController;
  final CieController controller;

  FbCieController(this.firebaseController, this.controller);

  @override
  void addObserver(CieListObserver observer) {
    return controller.addObserver(observer);
  }

  @override
  Future<List<Cie>> get cies => controller.cies;

  @override
  Future<int> enterCie(Cie cie) {
    firebaseController.logEvent(name: "add_cie");
    return controller.enterCie(cie);
  }

  @override
  Future<int> removeCie(Cie cie) {
    firebaseController.logEvent(name: "remove_cie");
    return controller.removeCie(cie);
  }

  @override
  set user(User user) {
    controller.user = user;
  }
}
