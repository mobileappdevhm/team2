import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final String content;

  SampleScreen(this.content);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(content),
    );
  }
}
