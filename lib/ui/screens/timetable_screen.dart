import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/mock/mock_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:courses_in_english/ui/basic_components/timetable_entry.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/ui/screens/sample_screen.dart';

class TimetableScreen extends StatefulWidget {
  void sortCourses() {
//    courses.sort((c1, c2) =>
//        (c1.timeAndDay.startHour * 100 + c1.timeAndDay.startMin) -
//        (c2.timeAndDay.startHour * 100 + c2.timeAndDay.startMin));
  }

  @override
  TimetableState createState() => new TimetableState();
}

class TimetableState extends State<TimetableScreen> {
  List<Course> initialCourseList = new List<Course>();

  final MockCourseProvider courseProvider = new MockCourseProvider();

  @override
  Widget build(BuildContext context) {
    final Future<List<Course>> courses = courseProvider.getCourses();
    courses.then((value) {
      initialCourseList = value;
      setState(() {});
    });
    Widget body;
    if (initialCourseList.isEmpty) {
      body = loadingScreenView();
    } else {
      body = TimetableView();
    }

    return new Center(
      child: body,
    );
  }

  Widget loadingScreenView() {
    return new Container(
      alignment: Alignment.center,
      child: new Text('Walking Cow', textAlign: TextAlign.center),
    );
  }

  Widget TimetableView() {
    List<Course> courseList = new List();
    List<Course> removeCourseList = new List();
    courseList.addAll(initialCourseList);
    DateTime today = new DateTime.now();
    List<Widget> timetableentries = [];
    timetableentries.add(new LineSeparator(
      title: "Today",
    ));
    courseList.sort((c1, c2) =>
        c1.timeAndDay.day * 100 +
        c1.timeAndDay.Slot -
        c2.timeAndDay.day * 100 +
        c2.timeAndDay.Slot);
    courseList.forEach((course) {
      if (course.timeAndDay.day == today.weekday) {
        timetableentries.add(new TimetableEntry(course));
        removeCourseList.add(course);
      }
    });
    removeCourseList.forEach((course) => courseList.remove(course));
    timetableentries.add(new LineSeparator(
      title: "Next Week",
    ));
    courseList.forEach((course) {
      if (course.timeAndDay.day > today.weekday) {
        timetableentries.add(new TimetableEntry(course));
        removeCourseList.add(course);
      }
    });
    removeCourseList.forEach((course) => courseList.remove(course));
    courseList.forEach((course) {
      timetableentries.add(new TimetableEntry(course));
    });

    return new ListView(children: timetableentries);
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
