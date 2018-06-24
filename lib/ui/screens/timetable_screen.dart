import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/timetable/timtable_course.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/timetable_entry.dart';
import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  final List<Course> courses;

  TimetableScreen(this.courses);

  @override
  TimetableState createState() => new TimetableState(this.courses);
}

class TimetableState extends State<TimetableScreen> {
  List<Course> courses = [];

  TimetableState(this.courses);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: timetableView(),
    );
  }

  Widget timetableView() {
    List<TimetableCourse> courseList = new List();
    List<TimetableCourse> removeCourseList = new List();

    if (courses.isNotEmpty) {
      print(courses.length.toString());
      courses.forEach((course) {
        for (int i = 0; i < course.dates.length; i++) {
          courseList.add(new TimetableCourse(course, i));
        }
      });
      DateTime today = new DateTime.now();
      List<Widget> timetableEntries = [];
      timetableEntries.add(
        new LineSeparator(
          title: "Today",
        ),
      );
      courseList.sort(
        (c1, c2) =>
            c1.course.dates[0].weekday * 100 +
            c1.course.dates[0].startHour -
            c2.course.dates[0].weekday * 100 +
            c2.course.dates[0].startHour,
      );
      courseList.forEach(
        (course) {
          if (course.course.dates[0].weekday == today.weekday) {
            timetableEntries.add(new TimetableEntry(course.course, 0));
            removeCourseList.add(course);
          }
        },
      );

      removeCourseList.forEach((course) => courseList.remove(course));

      timetableEntries.add(
        new LineSeparator(
          title: "Next Week",
        ),
      );
      courseList.forEach(
        (course) {
          if (course.course.dates[0].weekday > today.weekday) {
            timetableEntries.add(new TimetableEntry(course.course, 0));
            removeCourseList.add(course);
          }
        },
      );
      removeCourseList.forEach((course) => courseList.remove(course));
      courseList.forEach(
        (tCourse) {
          timetableEntries
              .add(new TimetableEntry(tCourse.course, tCourse.occurrence));
        },
      );

      return new ListView(children: timetableEntries);
    } else {
      return new Center(
          child: new Row(
        children: [
          new Text(
            "Sorry, you don't have any courses to display :(",
            style:
                new TextStyle(color: const Color(0xFF707070), fontSize: 17.0),
            softWrap: true,
            maxLines: 2,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }
  }
}
