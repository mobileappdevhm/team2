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
    courses.forEach((course) {
      for (int i = 0; i < course.timeAndDay.length; i++) {
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
          c1.course.timeAndDay[0].day * 100 +
          c1.course.timeAndDay[0].hour -
          c2.course.timeAndDay[0].day * 100 +
          c2.course.timeAndDay[0].hour,
    );
    courseList.forEach(
      (course) {
        if (course.course.timeAndDay[0].day == today.weekday) {
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
        if (course.course.timeAndDay[0].day > today.weekday) {
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
  }

  String slotToTime(int slot) {
    if (slot == 1) {
      return "8:15 - 9:45";
    } else if (slot == 2) {
      return "10:00 - 11:30";
    } else if (slot == 3) {
      return "11:45 - 13:15";
    } else if (slot == 4) {
      return "13:30 - 15:00";
    } else if (slot == 5) {
      return "15:15 - 16:45";
    } else if (slot == 6) {
      return "17:00 - 18:30";
    } else if (slot == 7) {
      return "18:45 - 20:15";
    } else {
      return "Wrong Slot";
    }
  }
}
