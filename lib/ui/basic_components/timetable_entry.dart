import 'package:courses_in_english/model/course/course.dart';
import 'package:flutter/material.dart';

/// Representation of a course (or lecture) for the timetable.
class TimetableEntry extends StatelessWidget {
  final Course course;

  TimetableEntry(this.course);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Center(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Text(
                    shortenCoursName(course.name),
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
//                        new Text("Prof:",
//                            style: new TextStyle(
//                              color: Colors.black,
//                              fontSize: 14.0,
//                              fontWeight: FontWeight.w400,
//                            )),
                    new Text(shortenCoursName(course.lecturerName),
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    new Text("Location: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        )),
                    new Text(course.location,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    new Text("Time: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        )),
                    new Text(course.timeAndDay.duration,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]))
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    new Text("Day: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        )),
                    new Text(intToDayString(course.timeAndDay.day),
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
              new Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                    new Text("Room: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        )),
                    new Text(course.room,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
            ],
          )
        ],
      ),
    ));
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

  String shortenCoursName(String name) {
    if (name.length > 30) {
      return name.substring(0, 28) + "..";
    }
    return name;
  }
}
