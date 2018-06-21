import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///TODO conncect with database i dont know how to
class CreateTimetableEntryScaffold extends StatefulWidget {
  CreateTimetableEntryScaffold();

  @override
  State<StatefulWidget> createState() {
    return new CreateTimetableEntryScaffoldState();
  }
}

class CreateTimetableEntryScaffoldState
    extends State<CreateTimetableEntryScaffold> {
  final Session session = new Session();
  String title = "";
  String professor = "";
  String location = "";
  String day = "";
  String room = "";
  String time = "";
  String duration = "";
  CreateTimetableEntryScaffoldState();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Custom Course"),
      ),
      body: new Container(
          child: new Column(
        children: <Widget>[
          new Card(
              child: new Text(
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
            decoration:
                new InputDecoration(hintText: "Day(Number from 1 to 7)"),
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
          new RaisedButton(
            onPressed: () {
              setState(() {
                int dayumber = int.tryParse(day);
                int durationnumber = int.tryParse(duration);
                int hour = int.tryParse(time.split(":")[0]);
                int min = int.tryParse(time.split(":")[1]);

                Course newCourse = new Course(
                    -1,
                    title,
                    "",
                    room,
                    0,
                    0.0,
                    0.0,
                    0.0,
                    CourseStatus.GREEN,
                    new Lecturer(-1, professor, ""),
                    new Department(null, null, null),
                    new Campus(null, location, null, null), [
                  new TimeAndDay(-1, dayumber, hour, min, durationnumber, -1)
                ]);
                session.addTimetableCourse(newCourse);
                AlertDialog dialog = new AlertDialog(
                  content: new Text(
                      "A new appointment was added to your timetable."),
                );
                showDialog(
                    context: context,
                    builder: (context) {
                      return dialog;
                    });
              });
            },
            child: new Text("submit",
                style: new TextStyle(
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
