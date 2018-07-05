import 'package:courses_in_english/model/course/time_and_day.dart';

/// Representation of a course (or lecture).
class CustomCourse {
  int id;

  bool custom;

  final String name;

  final String room;

  final List<TimeAndDay> dates;

  final String lecturer;

  final String department;

  final String location;

  CustomCourse(this.name, this.room, this.lecturer, this.department,
      this.location, this.dates,
      {this.id = -1, this.custom = true});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location;
    tempMap["department"] = this.department;
    tempMap["lecturer"] = this.lecturer;
    tempMap["room"] = this.room;

    return tempMap;
  }
}
