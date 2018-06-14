import 'package:courses_in_english/controller/session.dart';
import 'package:courses_in_english/ics_creator.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/ui/scaffolds/create_timetable_entry.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:courses_in_english/ui/screens/cie_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomeScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  static final int _initialIndex = 2;
  final PageController _controller =
      new PageController(initialPage: _initialIndex, keepPage: true);
  int _selectedIndex = _initialIndex;
  List<Course> displayedCourses = [];
  Session session = new Session();
  SearchBar searchBar;
  bool loading = true;

  // Builds the app bar depending on current screen
  // When on course_list screen, add search functionality
  AppBar buildAppBar(BuildContext context) {
    List<Widget> actions;
    if (_selectedIndex == 2) {
      actions = [
        new IconButton(
          icon: new Icon(Icons.calendar_today),
          onPressed: () {
            saveIcsFile(session.courses);
            AlertDialog dialog = new AlertDialog(
              content: new Text("Ics was saved to your Phones Storage"),
            );
            showDialog(
                context: context,
                builder: (context) {
                  return dialog;
                });
          },
        ),
        new IconButton(
          icon: new Icon(Icons.add),
          onPressed: () { Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) {
                return new CreateTimetableEntryScaffold(session.courses);
              },
            ),
          );
          },
        )
      ];
    }
    if (_selectedIndex == 0) {
      actions = [searchBar.getSearchAction(context)];
    }
    return new AppBar(
      title: new Text('Courses in English'),
      centerTitle: true,
      actions: actions,
    );
  }

  _updateList(String term) {
    List<Course> filteredCourses = new List<Course>();

    for (Course course in session.courses) {
      if ((course.name != null && course.name.contains(term)) ||
          course.description != null && course.description.contains(term)) {
        filteredCourses.add(course);
      }
    }

    setState(() {
      this.displayedCourses = filteredCourses;
    });
  }

  _HomeScaffoldState() {
    session.callbacks.add((session) {
      if (mounted) {
        setState(() {
          displayedCourses = session.courses;
          loading = false;
        });
      }
    });
    // TODO error handling for download
    session.download();
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
    if (!loading) {
      List<Widget> screens = [
        new CourseListScreen(displayedCourses, session.favorites),
        new LocationScreen(session.campuses),
        new TimetableScreen(session.courses),
        new FavoriteListScreen(session.favorites),
        new CieScreen(),
        new SettingsScreen()
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
              icon: new Icon(Icons.account_circle),
              title: new Text('Profile'),
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
