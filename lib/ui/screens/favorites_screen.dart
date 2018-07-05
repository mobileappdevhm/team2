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
    courseWidgets.add(new RoundedButton(text: new Text("Push Favorites"), onPressed: _onPushFavorites,));
    return courseWidgets;
  }

  void _onPushFavorites() {
    new Injector().favoritesController.pushFavorites();
  }

  Widget courseListView() {
    return new Container(
      constraints: new BoxConstraints.expand(),
      alignment: Alignment.center,
      child: new ListView(
        children: favs.length != 0 ? courseItems() : [new Center(child: new Text("You don't have any favorites :("))],
      ),
    );
  }
}
