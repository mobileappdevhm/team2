import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/sample_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter/material.dart';

class DrawerScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DrawerScaffoldState();
}

class _DrawerScaffoldState extends State<DrawerScaffold> {
  static final int _initialIndex = 2;
  int _selectedIndex = _initialIndex;
  PageController _controller = new PageController(initialPage: _initialIndex);
  bool coursesDownloaded = false;
  List<Course> courses = [];
  bool campusesDownloaded = false;
  List<Campus> campuses = [];
  bool departmentsDownloaded = false;
  Iterable<Department> departments;


  @override
  void initState() {
    super.initState();
    Data data = new Data();
    data.courseProvider.getCourses().then((courses) {
      setState(() {
        this.courses = courses;
        this.coursesDownloaded = true;
      });
    });
    data.campusProvider.getCampuses().then((campuses) {
      setState(() {
        this.campuses = campuses;
        this.campusesDownloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold;
    if (coursesDownloaded && campusesDownloaded) {
      scaffold = new Scaffold(
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(child: new Text('CiE App')),
              new ListTile(
                leading: new Icon(Icons.import_contacts),
                title: new Text('Courses'),
                onTap: () {
                  _onItemTap(0);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.map),
                title: new Text('Maps'),
                onTap: () {
                  _onItemTap(1);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.calendar_today),
                title: new Text('Timetable'),
                onTap: () {
                  _onItemTap(2);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.favorite_border),
                title: new Text('Favorites'),
                onTap: () {
                  _onItemTap(3);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.settings),
                title: new Text('Settings'),
                onTap: () {
                  _onItemTap(4);
                },
              )
            ],
          ),
        ),
        appBar: new AppBar(
          title: new Text('Courses in English'),
          centerTitle: true,
        ),
        body: new PageView(
          children: <Widget>[
            new CourseListScreen(courses, departments),
            new SampleScreen('Maps'),
            new TimetableScreen(courses),
            new SampleScreen('Favorites'),
            new SampleScreen('Settings'), //TODO fix
          ],
          onPageChanged: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
          // Never Scroll!
          physics: new NeverScrollableScrollPhysics(),
          controller: _controller,
        ),
      );
    } else {
      scaffold = new Scaffold(
          body: new Center(
        child: new Image(
          image: new AssetImage("res/anim_cow.gif"),
        ),
      ));
    }
    return scaffold;
  }

  void _onItemTap(int num) {
    _selectedIndex = num;
    _controller.jumpToPage(_selectedIndex);
    Navigator.pop(context);
  }
}
