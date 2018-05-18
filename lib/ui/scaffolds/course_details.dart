import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';

class CourseDetailsScaffold extends StatefulWidget {
  final Course course;

  CourseDetailsScaffold(this.course);

  @override
  State<StatefulWidget> createState() => new _CourseDetailsScaffold();
}

class _CourseDetailsScaffold extends State<CourseDetailsScaffold> {
  bool isFavored = false;

  @override
  void initState() {
    super.initState();
    new Data().favoritesProvider.isFavored(widget.course.id).then((isFavored) {
      setState(() {
        this.isFavored = isFavored;
      });
    });
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
                      color: isFavored ? Colors.pink : Colors.black12,
                    ),
                    iconSize: 48.0,
                    tooltip: isFavored
                        ? 'Remove this course from your favorites.'
                        : 'Add this course to your favorites.',
                    onPressed: () => new Data()
                        .favoritesProvider
                        .toggleFavorite(widget.course.id)
                        .then((favs) => setState(
                            () => isFavored = favs.contains(widget.course.id))))
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
                              style: new TextStyle(fontWeight: FontWeight.bold))
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
                              style: new TextStyle(fontWeight: FontWeight.bold))
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
                      onPressed: () {}, // TODO handle click on contact button
                      padding: new EdgeInsets.all(0.0),
                      child: new Row(
                        children: <Widget>[
                          new Icon(
                            Icons.mail_outline,
                            color: Colors.black54,
                            size: 32.0,
                          ),
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
}

class _AvailabilityPlaceholder extends StatelessWidget {
  final CourseStatus status;

  _AvailabilityPlaceholder(this.status);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        _getIcon(status),
        new Padding(
          padding: new EdgeInsets.only(left: 4.0),
          child: _getText(status),
        )
      ],
    );
  }

  static Icon _getIcon(CourseStatus status) {
    switch (status) {
      case CourseStatus.RED:
        return new Icon(
          Icons.cancel,
          color: Colors.red,
          size: 24.0,
        );
      case CourseStatus.YELLOW:
        return new Icon(
          Icons.remove_circle,
          color: Colors.amber,
          size: 24.0,
        );
      case CourseStatus.GREEN:
        return new Icon(
          Icons.check_circle,
          color: Colors.green,
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
            color: Colors.red,
            fontSize: 18.0,
          ),
        );
      case CourseStatus.YELLOW:
        return new Text(
          'Limited',
          style: new TextStyle(
            color: Colors.amber,
            fontSize: 18.0,
          ),
        );
      case CourseStatus.GREEN:
        return new Text(
          'Available',
          style: new TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          ),
        );
    }
    return new Text('Unknown');
  }
}
