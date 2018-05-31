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
    return new Center(
      child: courseListView(),
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
}
