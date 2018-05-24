import 'dart:async';

import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';
import 'package:courses_in_english/connect/dataprovider/data.dart';

class FavoriteListScreen extends StatefulWidget {
  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteListScreen> {
  List<Course> courseList = new List<Course>();
  final Data data = new Data();

  FavoriteListState() {
    final Set<int> favoriteCourseIDs = data.favoritesProvider.getFavorites();
    for (int courseID in favoriteCourseIDs) {
      data.courseProvider.getCourse(courseID).then((course) {
        if (mounted) {
          setState(() {
            courseList.add(course);
          });
        }
      });
    }
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
