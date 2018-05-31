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
    return new Card(
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Text(
                    shortenCoursName(course.name),
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                        new Text("Prof:",
//                            style: new TextStyle(
//                              color: Colors.black,
//                              fontSize: fontSize,
//                              fontWeight: FontWeight.w400,
//                            )),
                      new Text(
                        shortenCoursName(course.lecturerName),
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize + 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Location: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text(
                        course.location,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Time: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text(
                        course.timeAndDay[listpos].duration,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Day: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text(
                        intToDayString(course.timeAndDay[listpos].day),
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: vertPadding,
                    horizontal: horPadding,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Room: ",
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text(
                        course.room,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

  String shortenCoursName(String name) {
    if (name.length > 30) {
      return name.substring(0, 28) + "..";
    }
    return name;
  }
}
