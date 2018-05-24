import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class FavoriteListScreen extends StatefulWidget {
  final List<Course> courses;

  FavoriteListScreen(this.courses);

  @override
  FavoriteListState createState() => new FavoriteListState(this.courses);
}

class FavoriteListState extends State<FavoriteListScreen> {
  List<Course> courseList = new List<Course>();

  FavoriteListState(this.courseList);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: courseListView(),
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
