import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class FavoriteListScreen extends StatelessWidget {
  final List<Course> favs;

  FavoriteListScreen(this.favs);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new Center(
            child: courseListView(),
          ),
        ),
        new Container(
          child: new FlatButton(
            onPressed: ((){exportButtonPressed(context);}),
            child: new Container(
              child: new Text(
                "Export Favourites",
                style: new TextStyle(fontSize: 20.0, color: Colors.white70),
              ),
              alignment: Alignment.center,
            ),
          ),
          decoration: new BoxDecoration(color: Colors.black),
          constraints: new BoxConstraints(minHeight: 60.0),
        ),
      ],
    );
  }

  exportButtonPressed(BuildContext context) async {
    AlertDialog dialog = new AlertDialog(
      title: new Text("Export"),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Text("cancel"),
        ),
        new FlatButton(
          onPressed: (export()),
          child: new Text("Export to Server"),
        )
      ],
    );
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return dialog;
        });
  }

//Todo: write code to export the favourite List to the Server
  export() {}

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
