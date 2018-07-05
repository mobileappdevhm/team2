import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';
import 'package:courses_in_english/ui/basic_components/rounded_button.dart';
import 'package:flutter/material.dart';

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
    courseWidgets.add(new RoundedButton(
      text: new Text("Push Favorites"),
      onPressed: _onPushFavorites,
    ));
    return courseWidgets;
  }

  void _onPushFavorites() {
    new Injector().favoritesController.pushFavorites();
  }

  Widget courseListView() {
    return new Container(
      constraints: new BoxConstraints.expand(),
      alignment: Alignment.center,
      child: favs.length != 0
          ? new ListView(
              children: courseItems(),
            )
          : Center(
              child: new Row(
              children: [
                new Text(
                  "Sorry, you don't have any courses to display :(",
                  style: new TextStyle(
                      color: const Color(0xFF707070), fontSize: 17.0),
                  softWrap: true,
                  maxLines: 2,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
    );
  }
}
