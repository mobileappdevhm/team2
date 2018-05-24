import 'package:courses_in_english/ui/screens/locations_screen.dart';
import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/ui/screens/sample_screen.dart';
import 'package:courses_in_english/ui/screens/timetable_screen.dart';
import 'package:courses_in_english/ui/screens/favorites_screen.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  static final int _initialIndex = 2;
  final PageController _controller =
      new PageController(initialPage: _initialIndex, keepPage: true);
  final List<Widget> screens = [
    new CourseListScreen(),
    new LocationScreen(),
    new TimetableScreen(),
    new FavoriteListScreen(),
    new SampleScreen('Settings'),
  ];
  int _selectedIndex = _initialIndex;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
  }
}
