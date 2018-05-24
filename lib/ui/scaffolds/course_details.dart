import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsScaffold extends StatefulWidget {
  final Course course;

  CourseDetailsScaffold(this.course);

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
                          color: Colors.cyan,
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
                  children: <Widget>[
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
                    new RichText(
                      text: new TextSpan(
                        text: 'Hours per week: ',
                        style: new TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                        ),
                        children: [
                          new TextSpan(
                            text: widget.course.semesterWeekHours.toString(),
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new _AvailabilityPlaceholder(widget.course.status),
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
        'mailto:${lecturer.email}?subject=${widget.course.name}&body=Hello Professor ${lecturer.name},';
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

class _AvailabilityPlaceholder extends StatelessWidget {
  static const Color GREEN = const Color(0xFF83D183);
  static const Color YELLOW = const Color(0xFFFFCC66);
  static const Color RED = const Color(0xFFFF3366);
  final CourseStatus status;

  _AvailabilityPlaceholder(this.status);

  @override
  Widget build(BuildContext context) {
    return new Tooltip(
      message: _getTooltipMessage(status),
      child: new Row(
        children: <Widget>[
          _getIcon(status),
          new Padding(
            padding: new EdgeInsets.only(left: 4.0),
            child: _getText(status),
          ),
        ],
      ),
    );
  }

  static String _getTooltipMessage(CourseStatus status) {
    switch (status) {
      case CourseStatus.RED:
        return 'This course is only available to students from the \'home\' department';
      case CourseStatus.YELLOW:
        return 'Priority is given to students from \'home\' department';
      case CourseStatus.GREEN:
        return 'This course is available to students from all departments';
    }
    return 'There is no information regarding the availability of this course';
  }

  static Icon _getIcon(CourseStatus status) {
    switch (status) {
      case CourseStatus.RED:
        return new Icon(
          Icons.cancel,
          color: RED,
          size: 24.0,
        );
      case CourseStatus.YELLOW:
        return new Icon(
          Icons.remove_circle,
          color: YELLOW,
          size: 24.0,
        );
      case CourseStatus.GREEN:
        return new Icon(
          Icons.check_circle,
          color: GREEN,
          size: 24.0,
        );
    }
    // For flutter analyze
    return new Icon(
      Icons.help,
      color: Colors.black12,
    );
  }

  static Text _getText(CourseStatus status) {
    switch (status) {
      case CourseStatus.RED:
        return new Text(
          'Only \'Home\'',
          style: new TextStyle(
            color: RED,
            fontSize: 18.0,
          ),
        );
      case CourseStatus.YELLOW:
        return new Text(
          'Limited',
          style: new TextStyle(
            color: YELLOW,
            fontSize: 18.0,
          ),
        );
      case CourseStatus.GREEN:
        return new Text(
          'Available',
          style: new TextStyle(
            color: GREEN,
            fontSize: 18.0,
          ),
        );
    }
    return new Text('Unknown');
  }
}
