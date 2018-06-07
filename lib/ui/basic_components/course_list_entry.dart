
import 'package:courses_in_english/controller/session.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/availability_widget.dart';
import 'package:flutter/material.dart';

import '../scaffolds/course_details.dart';

const Color GREEN = const Color(0xFF83D183);
const Color YELLOW = const Color(0xFFFFCC66);
const Color RED = const Color(0xFFFF3366);
const Color HEART = const Color(0xFFFFA1A1);

class CourseListEntry extends StatelessWidget {
  final Course course;
  final bool favorite;
  final Session session = new Session();

  CourseListEntry(this.course, this.favorite);

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
                  return new CourseDetailsScaffold(course, favorite);
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
                    child: new IconButton(
                      padding: new EdgeInsets.all(0.0),
                      icon: new Icon(
                          favorite ? Icons.favorite : Icons.favorite_border),
                      iconSize: 9 * vw,
                      color: favorite ? HEART : Colors.black12,
                      onPressed: favorite
                          ? () => session.unfavorize(course)
                          : () => session.favorize(course),
                    ),
                  ),
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(
                              // TODO adjust to list of time and days
                              course.timeAndDay != null &&
                                      course.timeAndDay[0].day != null &&
                                      course.timeAndDay[0].duration != null
                                  ? course.timeAndDay[0].toDate()
                                  : "Time and Day Unknown",
                              style: new TextStyle(
                                  color: const Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0)),
                          padding: new EdgeInsets.only(bottom: vw * 2.2))),
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                    child: new Align(
                      child: new Text(
                        "Department ${course.department.number.toString().padLeft(2, '0')}",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: new Color(course.department.color)),
                        textScaleFactor: 1.2,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  new Container(
                      child: new Align(
                          child: new AvailabilityWidget(course.status)))
                ])
              ]),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          color: new Color(0xFFDDDDDD), width: 1.0))),
              padding: new EdgeInsets.only(
                  left: 3 * vw, top: 0.1 * vw, right: 3 * vw, bottom: 1 * vw))),
    );
  }
}
