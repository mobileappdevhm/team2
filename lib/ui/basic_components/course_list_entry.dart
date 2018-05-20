import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/department/department.dart';

import '../scaffolds/course_details.dart';
import 'status_widget.dart';

typedef void FavListener(bool favorite);
typedef void ClickCallback();

class CourseListEntry extends StatefulWidget {
  final Course course;
  final Department department;

  CourseListEntry(this.course, this.department);

  @override
  _CourseListEntryState createState() =>
      new _CourseListEntryState(course, department);
}

class _CourseListEntryState extends State {
  static const Color GREEN = const Color(0xFF83D183);
  static const Color YELLOW = const Color(0xFFFFCC66);
  static const Color RED = const Color(0xFFFF3366);
  static const Color HEART = const Color(0xFFFFA1A1);

  final Course course;
  final Department department;

  bool _favorite = false;

  _CourseListEntryState(this.course, this.department) {
    // TODO: Handle favorites logic (different branch)
    //_favorite = this.course.favourite;
  }

  void _toggleFav() {
    setState(() {
      _favorite = !_favorite;

      //TODO: Handle favorites (different branch)
      //favListener.call(_favorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double vw = size.width / 100;

    return new Material(
      child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new CourseDetailsScaffold(course);
                },
              ),
            );
          },
          child: new Container(
              child: new Column(children: <Widget>[
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Text(course.name,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.2)),
                  new Container(
                      child: new StatusWidget(course.status ==
                              CourseStatus.GREEN
                          ? GREEN
                          : course.status == CourseStatus.RED ? RED : YELLOW),
                      height: vw * 5,
                      width: vw * 5)
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(
                              course.description != null &&
                                      course.description.isNotEmpty
                                  ? course.description.substring(0, 100) + "..."
                                  : "No description available.. :(",
                              style: new TextStyle(color: Color(0xFF707070))),
                          padding:
                              EdgeInsets.only(top: vw * 2, bottom: vw * 2)))
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Align(
                          child: new Text("FK ${course.department}",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: department != null
                                      ? department.color
                                      : Colors.grey),
                              textScaleFactor: 1.2),
                          alignment: Alignment.centerLeft)),
                  new Expanded(
                      child: new Align(
                          child: new IconButton(
                              icon: new Icon(_favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              iconSize: 7 * vw,
                              color: HEART,
                              onPressed: () {
                                _toggleFav();
                              }),
                          alignment: Alignment.centerRight))
                ])
              ]),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          color: new Color(0xFFDDDDDD), width: 1.0))),
              padding: new EdgeInsets.only(
                  left: 3 * vw, top: 4 * vw, right: 3 * vw, bottom: 1 * vw))),
    );
  }
}
