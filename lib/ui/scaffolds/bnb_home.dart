import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  static final int _initialIndex = 2;
  final PageController _controller =
      new PageController(initialPage: _initialIndex, keepPage: true);
  int _selectedIndex = _initialIndex;
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
    data.departmentProvider.getDepartments().then((departments) {
      setState(() {
        this.departments = departments;
        this.departmentsDownloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold;
    if (coursesDownloaded && campusesDownloaded && departmentsDownloaded) {
      List<Widget> screens = [
        new CourseListScreen(courses, departments),
        new LocationScreen(campuses),
        new TimetableScreen(courses),
        new FavoriteListScreen(courses, departments),
        new SettingsScreen(),
      ];
      scaffold = new Scaffold(
        bottomNavigationBar: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.import_contacts),
              title: new Text('Courses'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.map),
              title: new Text('Maps'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.calendar_today),
              title: new Text('Timetable'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.favorite_border),
              title: new Text('Favorites'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              title: new Text('Settings'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
              _controller.jumpToPage(newIndex);
            });
          },
        ),
        appBar: new AppBar(
          title: new Text('Courses in English'),
          centerTitle: true,
        ),
        body: new PageView(
          controller: _controller,
          children: screens,
          onPageChanged: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
        ),
      );
    } else {
      scaffold = new Scaffold(
        body: new Center(
          child: new Image(image: new AssetImage("res/anim_cow.gif")),
        ),
      );
    }
    return scaffold;
  }
}
