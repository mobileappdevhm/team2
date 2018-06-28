import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/ui/basic_components/availability_widget.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const Color HEART = const Color(0xFFFFA1A1);

class CourseDetailsScaffold extends StatefulWidget {
  final Course course;
  final bool isFavored;

  CourseDetailsScaffold(this.course, this.isFavored);

  @override
  State<StatefulWidget> createState() =>
      new _CourseDetailsScaffoldState(course, isFavored);
}

class _CourseDetailsScaffoldState extends State<CourseDetailsScaffold> {
  final Course course;
  bool isFavored;
  final FavoritesController favoritesController =
      new Injector().favoritesController;

  _CourseDetailsScaffoldState(this.course, this.isFavored);

  @override
  Widget build(BuildContext context) {
    String date = "";
    course.dates.forEach((lecture) {
      date += lecture.toDate() + "\n";
    });

    if (date == "") {
      date = "Time and Day Unknown";
    } else {
      date.substring(0, date.length - 1);
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Course Details",
        ),
        centerTitle: true,
      ),
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        course.name,
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      new Padding(padding: new EdgeInsets.only(top: 1.5)),
                      new Text(
                        "Department " +
                            course.department.number.toString().padLeft(2, '0'),
                        style: TextStyle(
                            color: Color(course.department.flutterColor)),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                new IconButton(
                  icon: new Icon(
                    isFavored ? Icons.favorite : Icons.favorite_border,
                    color: isFavored ? HEART : Colors.black12,
                  ),
                  iconSize: 48.0,
                  tooltip: isFavored
                      ? 'Remove this course from your favorites.'
                      : 'Add this course to your favorites.',
                  onPressed: () {
                    if (isFavored) {
                      favoritesController.unFavorizeCourse(course);
                    } else {
                      favoritesController.favorizeCourse(course);
                    }
                    setState(() {
                      isFavored = !isFavored;
                    });
                  },
                ),
              ],
            ),
            new LineSeparator(title: 'Description'),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: new SingleChildScrollView(
                  child: new Text(
                    course.description,
                    style: new TextStyle(color: Colors.black45),
                  ),
                ),
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                        // TODO adjust to list of timeanddays
                        course.dates != null &&
                                course.dates.length > 0 &&
                                course.dates[0].weekday != null &&
                                course.dates[0].duration != null
                            ? course.dates[0].toDate()
                            : "Time and Day Unknown",
                        style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    new Padding(
                        padding: new EdgeInsets.only(
                            top: 8.0)), //TODO Change to variable height
                    new RichText(
                      text: new TextSpan(
                        text: 'Credit points (ECTS): ',
                        style: new TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                        children: [
                          new TextSpan(
                              text: course.ects.toString(),
                              style: new TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    new Padding(
                        padding: new EdgeInsets.only(
                            top: 8.0)), //TODO Change to variable height
                    new RichText(
                      text: new TextSpan(
                        text: 'Credit points (US): ',
                        style: new TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                        children: [
                          new TextSpan(
                            text: 3.toString(), // TODO US Credit points
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                        padding: new EdgeInsets.only(
                            top: 5.0)), //TODO Change to variable height
                  ],
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new AvailabilityWidget(course.courseStatus),
                    new Padding(padding: new EdgeInsets.only(top: 4.0)),
                    new Text(
                        course.lecturer.name != null
                            ? "${course.lecturer.name}"
                            : "Professor Unknown",
                        style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                    new FlatButton(
                      onPressed: () => sendMail(),
                      padding: new EdgeInsets.all(0.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.mail_outline,
                              color: Colors.black54, size: 24.0),
                          new Padding(
                            padding: new EdgeInsets.only(left: 4.0),
                            child: new Text(
                              'Contact',
                              style: new TextStyle(
                                color: Colors.black54,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendMail() async {
    Lecturer lecturer = course.lecturer; // Android and iOS
    final uri = 'mailto:${lecturer.email}?subject=${course
        .name}&body=Hello Professor ${lecturer.name},';
    print(uri);
    if (await canLaunch(uri)) {
      launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
