import 'package:flutter/material.dart';
import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/scaffolds/course_details.dart';

class SampleCourseListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SampleCourseListScreenState();
}

class _SampleCourseListScreenState extends State<SampleCourseListScreen> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    Data data = new Data();
    data.courseProvider.getCourses().then((courses) {
      setState(() {
        this.courses = courses;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        return new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) {
                      return new CourseDetailsScaffold(courses[index]);
                    },
                  ),
                );
              },
              color: Colors.deepOrangeAccent,
              child: new Text(courses[index].name),
              textColor: Colors.white,
            ));
      },
      itemCount: courses.length,
    );
  }
}
