import 'package:flutter/material.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class CourseListScreen extends StatelessWidget {
  final List<Course> courseList;
  final Iterable<Department> departments;
  //final CourseListEntry courseWidgets;
  CourseListScreen(this.courseList, this.departments);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: ListView(
        children: createCourseWidgets(),
      ),
    ));
  }

  List<Widget> createCourseWidgets() {
    List<Widget> courseWidgets = new List<Widget>();
    for (Course course in courseList) {
      Department department = departments
          .firstWhere((Department d) => d.number == course.department);
      courseWidgets.add(new CourseListEntry(course, department));
    }
    return courseWidgets;
  }
}
