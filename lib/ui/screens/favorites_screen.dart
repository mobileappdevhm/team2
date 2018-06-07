import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class FavoriteListScreen extends StatelessWidget {
  final List<Course> favs;

  FavoriteListScreen(this.favs);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: courseListView(),
    );
  }

  List<Widget> courseItems() {
    List<Widget> courseWidgets = new List<Widget>();
    for (var course in favs) {
      courseWidgets.add(new CourseListEntry(course, true));
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
