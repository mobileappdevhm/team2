import 'package:courses_in_english/connect/dataprovider/favorites/favorites_observer.dart';
import 'package:flutter/material.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/connect/dataprovider/data.dart';
import '../scaffolds/course_details.dart';
import 'status_widget.dart';

class CourseListEntry extends StatefulWidget {
  final Course course;

  CourseListEntry(this.course);

  @override
  _CourseListEntryState createState() => new _CourseListEntryState(course);
}

class _CourseListEntryState extends State implements FavoritesObserver {
  static const Color GREEN = const Color(0xFF83D183);
  static const Color YELLOW = const Color(0xFFFFCC66);
  static const Color RED = const Color(0xFFFF3366);
  static const Color HEART = const Color(0xFFFFA1A1);

  final Course course;
  Department department;
  Lecturer lecturer;
  Data data = new Data();

  bool _favorite = false;

  _CourseListEntryState(this.course);

  void _toggleFav() {
    data.favoritesProvider.toggleFavorite(course.id);
  }

  @override
  void initState() {
    super.initState();

    data.favoritesProvider.addObserver(this);
    _favorite = data.favoritesProvider.isFavored(course.id);

    data.departmentProvider.getDepartmentByNumber(course.department).then(
      (department) {
        setState(() => this.department = department);

        data.lecturerProvider
            .getLecturerById(course.lecturerId)
            .then((lecturer) => setState(() => this.lecturer = lecturer));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double vw = size.width / 100;

    return new Material(
      child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new CourseDetailsScaffold(course);
                },
              ),
            );
          },
          child: new Container(
              child: new Column(children: <Widget>[
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Text(course.name,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: new TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.2)),
                  new Container(
                      child: new StatusWidget(course.status ==
                              CourseStatus.GREEN
                          ? GREEN
                          : course.status == CourseStatus.RED ? RED : YELLOW),
                      height: vw * 5,
                      width: vw * 5)
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Text(
                              lecturer != null && lecturer.name.isNotEmpty
                                  ? "By " + lecturer.name
                                  : "Professor unknown",
                              style: new TextStyle(
                                  color: Color(0xFF707070),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0)),
                          padding:
                              EdgeInsets.only(top: vw * 2, bottom: vw * 2)))
                ]),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new Align(
                          child: new Text("FK ${course.department}",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: department != null
                                      ? department.color
                                      : Colors.grey),
                              textScaleFactor: 1.2),
                          alignment: Alignment.centerLeft)),
                  new Expanded(
                      child: new Align(
                          child: new IconButton(
                              icon: new Icon(_favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              iconSize: 7 * vw,
                              color: HEART,
                              onPressed: () {
                                _toggleFav();
                              }),
                          alignment: Alignment.centerRight))
                ])
              ]),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(
                          color: new Color(0xFFDDDDDD), width: 1.0))),
              padding: new EdgeInsets.only(
                  left: 3 * vw, top: 4 * vw, right: 3 * vw, bottom: 1 * vw))),
    );
  }

  @override
  void onFavoriteToggled() =>
      setState(() => _favorite = data.favoritesProvider.isFavored(course.id));

  @override
  void dispose() {
    super.dispose();
    data.favoritesProvider.removeObserver(this);
  }
}
