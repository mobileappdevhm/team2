import 'package:courses_in_english/ui/scaffolds/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cie App',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LoginScreen(),
    );
  }
}
