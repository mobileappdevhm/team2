import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new CieApp());

class CieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Session s = new Session();

    return new MaterialApp(
      title: 'Cie App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LoginScreen(),
      navigatorObservers: [
        s.observer
      ],
    );
  }
}
