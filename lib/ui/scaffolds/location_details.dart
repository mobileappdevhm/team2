import 'dart:math';
import 'dart:ui' as ui;

import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationDetailScreen extends StatefulWidget {
  final int campusId;

  LocationDetailScreen(this.campusId);

  @override
  State<StatefulWidget> createState() =>
      new _LocationDetailScreenState(campusId);
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

    Widget body;
    if (this.campus != null) {
      body = new Stack(
        children: <Widget>[
          new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new ExactAssetImage(this.campus.image),
                fit: BoxFit.cover,
              )),
              child: new BackdropFilter(
                filter: new ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              )),
          new Container(
              margin: new EdgeInsets.all(p * 3),
              child: new Image.asset(this.campus.image))
        ],
        alignment: Alignment.center,
      );
    } else {
      body = new Center(
          child: new Image(image: new AssetImage("res/anim_cow.gif")));
    }

    return new Scaffold(
        appBar: new AppBar(title: new Text("Maps"), centerTitle: true),
        body: body);
  }
}
