import 'package:courses_in_english/controller/favorites_controller.dart';
import 'package:courses_in_english/controller/injector.dart';
import 'package:courses_in_english/model/content.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/ui/screens/cie_screen.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:courses_in_english/ui/screens/settings_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomeScaffold extends StatefulWidget {
  final Content content;

  HomeScaffold(this.content);

  @override
  State<StatefulWidget> createState() => new _HomeScaffoldState(this.content);
}

class _HomeScaffoldState extends State<HomeScaffold>
    implements FavoriteListObserver {
  static final int _initialIndex = 2;
  final PageController _controller =
      new PageController(initialPage: _initialIndex, keepPage: true);
  int _selectedIndex = _initialIndex;
  final Content content;
  List<Course> displayedCourses = [];
  List<Course> favorites = [];
  SearchBar searchBar;
  List<DropdownMenuItem<Department>> dropdownMenuItems = [];
  bool isFiltered = false;
  String _searchTerm;

  _HomeScaffoldState(this.content) {
    displayedCourses = content.courses;
    new Injector().favoritesController.addObserver(this);
    dropdownMenuItems = content.departments
        .map((department) => new DropdownMenuItem(
              child: new Text(
                  'FK ${department.number.toString().padLeft(2, '0')}'),
              value: department,
            ))
        .toList();
    // Initialize searchBar
    searchBar = new SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: _searchCourses,
        buildDefaultAppBar: buildAppBar);
  }

  // Builds the app bar depending on current screen
  // When on course_list screen, add search functionality
  AppBar buildAppBar(BuildContext context) {
    List<Widget> actions;

    if (_selectedIndex == 0) {
      actions = [
        searchBar.getSearchAction(context),
        new DropdownButton<Department>(
            items: dropdownMenuItems,
            onChanged: (Department dep) {
              _filterCoursesByDepartment(dep);
            },
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            hint: Text(
              "Departments",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ];
      if (isFiltered) {
        actions.insert(
            0,
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    this.displayedCourses = content.courses;
                    isFiltered = false;
                  });
                }));
      }
    } else {
      actions = [
        new IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Scaffold(
                            appBar: new AppBar(
                              title: new Text("Profile"),
                            ),
                            body: new CieScreen(),
                          )));
            })
      ];
    }

    List<String> titles = [
      "All Courses",
      "Maps",
      "Timetable",
      "Favorites",
      "Settings"
    ];

    return new AppBar(
      title: isFiltered
          ? Text("search: \"" + _searchTerm + "\"")
          : Text(titles[_selectedIndex]),
      centerTitle: false,
      actions: actions,
    );
  }

  _searchCourses(String term) {
    List<Course> filteredCourses = new List<Course>();

    for (Course course in content.courses) {
      if ((course.name != null && course.name.contains(term)) ||
          course.description != null && course.description.contains(term)) {
        filteredCourses.add(course);
      }
    }

    setState(() {
      this.displayedCourses = filteredCourses;
      isFiltered = true;
      _searchTerm = term;
    });
  }

  _filterCoursesByDepartment(Department dep) {
    List<Course> filteredCourses = new List<Course>();

    // Filter out only those that correspond to the selected department
    _searchTerm = "FK " + dep.number.toString();
    for (Course course in content.courses) {
      if ((course.department.id == dep.id)) {
        filteredCourses.add(course);
      }
    }

    setState(() {
      this.displayedCourses = filteredCourses;
      isFiltered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold;
    List<Widget> screens = [
      new CourseListScreen(displayedCourses, favorites),
      new LocationScreen(content.campuses),
      //TODO add relevant courses
      new TimetableScreen([]),
      new FavoriteListScreen(favorites),
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
            icon: new Icon(Icons.settings),
            title: new Text('Settings'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;

            // Make sure to reset filter state if user left without clearning previously
            if (_selectedIndex == 0) {
              isFiltered = false;
              this.displayedCourses = content.courses;
            }

            _controller.jumpToPage(newIndex);
            new Injector().firebaseController?.setCurrentScreen(
                screenName: screens[_selectedIndex].toStringShort());
          });
        },
      ),
      appBar: searchBar.build(context),
      floatingActionButton: (_selectedIndex == 2)
          ? new FloatingActionButton(
              // TODO add onPressed for ICS export
              child: Icon(Icons.event_note),
              onPressed: () {})
          : null,
      body: new PageView(
        controller: _controller,
        children: screens,
        onPageChanged: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
            new Injector().firebaseController?.setCurrentScreen(
                screenName: screens[_selectedIndex].toStringShort());
          });
        },
      ),
    );

    return scaffold;
  }

  @override
  void onFavoritesUpdated(List<Course> favorites) =>
      setState(() => this.favorites = favorites);
}
