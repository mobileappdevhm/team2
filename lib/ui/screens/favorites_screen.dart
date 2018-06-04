import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class FavoriteListScreen extends StatefulWidget {
  final List<Course> courses;
  final Iterable<Department> departments;

  FavoriteListScreen(this.courses, this.departments);

  @override
  FavoriteListState createState() =>
      new FavoriteListState(this.courses, this.departments);
}

class FavoriteListState extends State<FavoriteListScreen>
    implements FavoritesObserver {
  final List<Course> courseList;
  final Iterable<Department> departments;

  List<Course> favs = [];
  final Data data = new Data();

  FavoriteListState(this.courseList, this.departments);

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
            onPressed: exportButtonPressed(),
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

  List<Widget> courseItems() {
    //return favs.map((course) => new CourseListEntry(course, department)).toList();
    List<Widget> courseWidgets = new List<Widget>();
    for (var course in favs) {
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
        children: courseItems(),
      ),
    );
  }

  void updateFavs() {
    setState(() => favs = courseList
        .where((course) => data.favoritesProvider.isFavored(course.id))
        .toList());
  }

  @override
  void initState() {
    super.initState();
    updateFavs();
    data.favoritesProvider.addObserver(this);
  }

  @override
  void onFavoriteToggled() => updateFavs();

  @override
  void dispose() {
    super.dispose();
    data.favoritesProvider.removeObserver(this);
  }

  exportButtonPressed() async {
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
}
