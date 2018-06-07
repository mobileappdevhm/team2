import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/basic_components/course_list_entry.dart';

class FavoriteListScreen extends StatefulWidget {
  final List<Course> courses;
  FavoriteListScreen(this.courses);

  @override
  FavoriteListState createState() =>
      new FavoriteListState(this.courses);
}

class FavoriteListState extends State<FavoriteListScreen>
    implements FavoritesObserver {
  final List<Course> courseList;

  List<Course> favs = [];
  final Data data = new Data();

  FavoriteListState(this.courseList);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: courseListView(),
    );
  }

  List<Widget> courseItems() {
    //return favs.map((course) => new CourseListEntry(course, department)).toList();
    List<Widget> courseWidgets = new List<Widget>();
    for (var course in favs) {
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
}
