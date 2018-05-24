import 'dart:async';

import 'package:flutter/material.dart';
import 'package:courses_in_english/connect/dataprovider/course/mock/mock_course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class CourseListScreen extends StatefulWidget {
  @override
  CourseListState createState() => new CourseListState();
}

class CourseListState extends State<CourseListScreen> {
  List<Course> courseList = new List<Course>();
  final MockCourseProvider courseProvider = new MockCourseProvider();

  CourseListState() {
    final Future<List<Course>> courses = courseProvider.getCourses();
    courses.then((value) {
      courseList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (courseList.isEmpty) {
      body = loadingScreenView();
    } else {
      body = courseListView();
    }

    return new Center(
      child: body,
    );
  }

  Widget loadingScreenView() {
    return new Container(
      alignment: Alignment.center,
      child: new Text('Animation Time', textAlign: TextAlign.center),
    );
  }

  List<Widget> courseItems() {
    List<Widget> courseWidgets = new List<Widget>();
    for (var course in courseList) {
      courseWidgets.add(new CourseListEntry(course));
    }
    return courseWidgets;
  }

  Widget courseListView() {
    return new Container(
      constraints: new BoxConstraints.expand(),
      alignment: Alignment.center,
      child: new ListView(
        children: courseItems(),
      ),
    );
  }
}
