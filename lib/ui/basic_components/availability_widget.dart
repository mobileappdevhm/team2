import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course_status.dart';

class AvailabilityWidget extends StatelessWidget {
  static const Color GREEN = const Color(0xFF83D183);
  static const Color YELLOW = const Color(0xFFFFCC66);
  static const Color RED = const Color(0xFFFF3366);
  final CourseStatus status;

  AvailabilityWidget(this.status);

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
