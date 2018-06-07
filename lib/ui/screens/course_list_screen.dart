import 'package:flutter/material.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class CourseListScreen extends StatefulWidget {
  final List<Course> courseList;
  final Iterable<Department> departments;

  CourseListScreen(this.courseList, this.departments);

  @override
  CourseListState createState() =>
      new CourseListState(this.courseList, this.departments);
}

class CourseListState extends State<CourseListScreen> {
  final List<Course> courseList;
  final Iterable<Department> departments;

  CourseListState(this.courseList, this.departments);

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

  List<Widget> courseWidgets() {
    List<Widget> courseWidgets = new List<Widget>();
    for (Course course in courseList) {
      Department department = departments
          .firstWhere((Department d) => d.number == course.department);
      courseWidgets.add(new CourseListEntry(course, department));
    }
    return courseWidgets;
  }

  Widget courseListView() {
    return new Container(
      constraints: new BoxConstraints.expand(),
      alignment: Alignment.center,
      child: new ListView(
        children: courseWidgets(),
      ),
    );
  }
}
