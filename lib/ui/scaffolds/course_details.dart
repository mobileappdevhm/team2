import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:courses_in_english/ui/basic_components/availability_widget.dart';

class CourseDetailsScaffold extends StatefulWidget {
  final Course course;
  final Department department;

  CourseDetailsScaffold(this.course, this.department);

  @override
  State<StatefulWidget> createState() => new _CourseDetailsScaffold();
}

class _CourseDetailsScaffold extends State<CourseDetailsScaffold>
    implements FavoritesObserver {
  static const Color HEART = const Color(0xFFFFA1A1);
  bool isFavored = false;
  final Data data = new Data();

  @override
  void initState() {
    super.initState();
    data.favoritesProvider.addObserver(this);
    isFavored = data.favoritesProvider.isFavored(widget.course.id);
  }

  @override
  void dispose() {
    super.dispose();
    data.favoritesProvider.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
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
                        widget.course.name,
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.black54,
                        ),
                      ),
                      new Text(
                        'Department ${widget.course.department.toString().padLeft(2, '0')}',
                        style: new TextStyle(
                          color: widget.department.color,
                          fontWeight: FontWeight.bold,
                        ),
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
                  onPressed: () => new Data()
                      .favoritesProvider
                      .toggleFavorite(widget.course.id),
                ),
              ],
            ),
            new LineSeparator(title: 'Description'),
            new Expanded(
              child: new Padding(
                padding: new EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: new SingleChildScrollView(
                  child: new Text(
                    widget.course.description,
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
                        widget.course.timeAndDay != null &&
                                widget.course.timeAndDay.day != null &&
                                widget.course.timeAndDay.duration != null
                            ? widget.course.timeAndDay.toDate()
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
                          fontSize: 18.0,
                        ),
                        children: [
                          new TextSpan(
                              text: widget.course.ects.toString(),
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
                          fontSize: 18.0,
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
                    new AvailabilityWidget(widget.course.status),
                    new Padding(
                        padding: new EdgeInsets.only(
                      top: 4.0,
                    )),
                    new Text(
                        widget.course.lecturerName != null
                            ? "${widget.course.lecturerName}"
                            : "Professor Unknown",
                        style: new TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                    new Padding(
                        padding: new EdgeInsets.only(
                      top: 2.0,
                    )),
                    new FlatButton(
                      onPressed: () => sendMail(),
                      padding: new EdgeInsets.all(0.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(Icons.mail_outline,
                              color: Colors.black54, size: 32.0),
                          new Padding(
                            padding: new EdgeInsets.only(left: 4.0),
                            child: new Text(
                              'Contact',
                              style: new TextStyle(
                                color: Colors.black54,
                                fontSize: 24.0,
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
    Lecturer lecturer;
    Data data = new Data();
    lecturer =
        await data.lecturerProvider.getLecturerById(widget.course.lecturerId);
    // Android and iOS
    final uri =
        'mailto:${lecturer.email}?subject=${widget.course.name}&body=Hello Professor ${widget.course.lecturerName},';
    print(uri);
    if (await canLaunch(uri)) {
      launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  @override
  void onFavoriteToggled() => setState(
      () => isFavored = data.favoritesProvider.isFavored(widget.course.id));
}
