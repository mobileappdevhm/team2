import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
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
  List<Course> displayedCourses = [];
  // Keep an attribute with all courses to avoid repeated requests
  List<Course> allCourses = [];
  bool campusesDownloaded = false;
  List<Campus> campuses = [];
  bool departmentsDownloaded = false;
  Iterable<Department> departments;
  SearchBar searchBar;
  Data data = new Data();

  // Builds the app bar depending on current screen
  // When on course_list screen, add search functionality
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Courses in English'),
      centerTitle: true,
      actions:
          _selectedIndex == 0 ? [searchBar.getSearchAction(context)] : null,
    );
  }

  _updateList(String term) {
    List<Course> filteredCourses = new List<Course>();

    for (Course course in allCourses) {
      if ((course.name != null && course.name.contains(term)) ||
          course.description != null && course.description.contains(term)) {
        filteredCourses.add(course);
      }
    }

    setState(() {
      this.displayedCourses = filteredCourses;
    });
  }

  @override
  void initState() {
    super.initState();

    data.courseProvider.getCourses().then((courses) {
      setState(() {
        this.displayedCourses = this.allCourses = courses;
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

    // Initialize searchBar
    searchBar = new SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: _updateList,
        buildDefaultAppBar: buildAppBar);
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold;
    if (coursesDownloaded && campusesDownloaded && departmentsDownloaded) {
      List<Widget> screens = [
        new CourseListScreen(displayedCourses, departments),
        new LocationScreen(campuses),
        new TimetableScreen(allCourses),
        new FavoriteListScreen(allCourses, departments),
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
        appBar: searchBar.build(context),
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
