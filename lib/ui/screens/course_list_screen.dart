import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class CourseListScreen extends StatelessWidget {
  final List<Course> courseList;
  final List<Course> favorites;

  CourseListScreen(this.courseList, this.favorites);

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

  bool isFavorite(Course course) => favorites.contains(course);

  Widget loadingScreenView() {
    return new Container(
      alignment: Alignment.center,
      child: new Text('No Courses found :(', textAlign: TextAlign.center),
    );
  }

  List<Widget> courseItems() {
    List<Widget> courseWidgets = new List<Widget>();
    for (var course in courseList) {
      courseWidgets.add(new CourseListEntry(course, isFavorite(course)));
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
