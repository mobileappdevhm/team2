import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/ui/basic_components/availability_widget.dart';
import 'package:courses_in_english/ui/basic_components/line_separator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateTimetableEntryScaffold extends StatefulWidget {
  final Session session = new Session();
  final List<Course> courses;

  CreateTimetableEntryScaffold(this.courses);

  @override
  State<StatefulWidget> createState() {
    return new CreateTimetableEntryScaffoldState(courses);
  }
}

class CreateTimetableEntryScaffoldState
    extends State<CreateTimetableEntryScaffold> {
  CreateTimetableEntryScaffoldState(this.courses);
  final List<Course> courses;
  String title = "";
  String professor = "";
  String location = "";
  String day = "";
  String room = "";
  String time = "";
  String duration = "";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Custom Course"),
      ),
      body: new Container(
          child: new Column(
        children: <Widget>[
          new Card(child: new Text(
              "Enter the following data to create a custom timetable enrty:",
              style: new TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ))),
          new TextField(
            decoration: new InputDecoration(hintText: "Course Name"),
            onChanged: (String s) {
              setState(() {
                title = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Professor"),
            onChanged: (String s) {
              setState(() {
                professor = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Location"),
            onChanged: (String s) {
              setState(() {
                location = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Day"),
            onChanged: (String s) {
              setState(() {
                day = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Time e.g. 18:45"),
            onChanged: (String s) {
              setState(() {
                time = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Duration in minutes"),
            onChanged: (String s) {
              setState(() {
                duration = s;
              });
            },
          ),
          new TextField(
            decoration: new InputDecoration(hintText: "Room"),
            onChanged: (String s) {
              setState(() {
                room = s;
              });
            },
          ),
          new MaterialButton(
            onPressed: () {
              setState(() {
                courses.add(new Course(
                    99,
                    title,
                    "",
                    room,
                    0,
                    0.0,
                    0.0,
                    0.0,
                    CourseStatus.GREEN,
                    new Lecturer(99, professor, ""),
                    new Department(null, null, location),
                    new Campus(null, location, null, null)));
              });
            },
            child: new Text("submit",style: new TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            )),
            color: Colors.redAccent,
            elevation: 3.5,
          )
        ],
      )),
    );
  }
}
