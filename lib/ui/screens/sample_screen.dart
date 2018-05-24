import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final String content;

  SampleScreen(this.content);

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
      children: <Widget>[
        new Expanded(
          child: new Row(
            children: <Widget>[new Expanded(child: new Image(image: new AssetImage("res/anim_cow.gif")))],
          ),
        ),
        new Expanded(
            child: new Row(
          children: <Widget>[new Expanded(child: new Center(child: new Text(content)))],
        ))
      ],
    ));
  }
}
