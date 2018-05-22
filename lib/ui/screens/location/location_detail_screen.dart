import 'dart:math';
import 'dart:ui';

import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/ui/animation/animated_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationDetailScreen extends StatefulWidget {
  final int campusId;

  LocationDetailScreen(this.campusId);

  @override
  State<StatefulWidget> createState() => new _LocationDetailScreenState(campusId);
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  final int campusId;
  Campus campus;

  _LocationDetailScreenState(this.campusId) {
    new Data().campusProvider.getCampuses().then((campuses) {
      setState(() {
        this.campus = campuses.firstWhere((campus) => campus.id == campusId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double p = min(size.width, size.height) / 100;

    Widget body = null;
    if (this.campus != null) {
      body = new Stack(
        children: <Widget>[
          new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new ExactAssetImage(this.campus.imagePath),
                fit: BoxFit.cover,
              )),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              )),
          new Container(margin: new EdgeInsets.all(p * 3), child: new Image.asset(this.campus.imagePath))
        ],
        alignment: Alignment.center,
      );
    } else {
      body = new Center(
          child: new AnimatedImage(animationImagePrefix: "frame", animationRootFolder: "res/cow-anim", duration: const Duration(seconds: 2), imageCount: 120));
    }

    return new Scaffold(appBar: new AppBar(title: new Text("Maps"), centerTitle: true), body: body);
  }
}
