import 'package:courses_in_english/ui/animation/animated_image.dart';
import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final String content;
  final AnimatedImage image =
      new AnimatedImage(animationImagePrefix: "frame", animationRootFolder: "res/cow-anim", duration: const Duration(seconds: 2), imageCount: 120);

  SampleScreen(this.content);

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
      children: <Widget>[
        new Expanded(
          child: new Row(
            children: <Widget>[new Expanded(child: image)],
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
