import 'dart:math' as math;

import 'package:courses_in_english/ui/scaffolds/add_custom_course.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimetableActionButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimetableActionButtonState();
}

class TimetableActionButtonState extends State<TimetableActionButton>
    with TickerProviderStateMixin {
  AnimationController _controller;

  TimetableActionButtonState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget build(BuildContext context) {
    var icons;
    if (defaultTargetPlatform == TargetPlatform.android) {
      icons = [Icons.add, Icons.event_note];
    } else {
      icons = [Icons.add];
    }

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: new FloatingActionButton(
              mini: true,
              child: new Icon(icons[index]),
              onPressed: () => _onPressed(index),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0.85 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed
                      ? Icons.add_to_photos
                      : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }

  void _onPressed(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new AddCustomCourseScaffold()));
        break;
      case 1:
    }
  }
}
