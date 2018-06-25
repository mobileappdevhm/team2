import 'package:courses_in_english/model/course/course.dart';
import 'package:flutter/material.dart';

/// Representation of a course (or lecture) for the timetable.
class TimetableEntry extends StatelessWidget {
  final Course course;
  final int listpos;
  static const double fontSize = 14.0;
  static const double horPadding = 14.0;
  static const double vertPadding = 8.0;

  TimetableEntry(this.course, this.listpos);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double vw = size.width / 100;
    return new Card(
      child: new InkWell(
          onTap: null,
          child: new Container(
              child: new Column(children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                        child: new Text(course.name,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: new TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2)),
                    // TODO is course custom
                    new Container(
                      child: new IconButton(
                        padding: new EdgeInsets.all(0.0),
                        icon: new Icon(Icons.delete),
                        iconSize: 6.5 * vw,
                        color: Colors.black12,
                        onPressed: null,
                      ),
                    ),
                  ],
                ),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(course.dates[0].toString(),
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2))),
                  new Expanded(
                      child: new Container(
                          child: new Text(course.room,
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2)))
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(course.lecturer.name,
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2))),
                  new Expanded(
                      child: new Container(
                          child: new Text(course.location.name,
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2))),
                ])
              ]),
              padding: new EdgeInsets.only(
                  left: 3 * vw,
                  top: 0.1 * vw,
                  right: 1.5 * vw,
                  bottom: 1 * vw))),
    );
  }

  String intToDayString(int day) {
    String result = "defalut value";
    if (day == 1) {
      result = "Monday";
    } else if (day == 2) {
      result = "Tuesday";
    } else if (day == 3) {
      result = "Wednesday";
    } else if (day == 4) {
      result = "Thursday";
    } else if (day == 5) {
      result = "Friday";
    }
    return result;
  }
}
