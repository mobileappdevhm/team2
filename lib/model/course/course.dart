import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/custom_course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/model/user/user.dart';

/// Representation of a course (or lecture).
class Course {
  final int id;

  final String name;

  final String description;

  final String room;

  final int availableSlots;

  final double ects;

  final double usCredits;

  final double semesterWeekHours;

  final List<TimeAndDay> dates;

  final CourseStatus courseStatus;

  final Lecturer lecturer;

  final Department department;

  final Campus location;

  const Course([
    this.id,
    this.name,
    this.description,
    this.room,
    this.availableSlots,
    this.ects,
    this.usCredits,
    this.semesterWeekHours,
    this.courseStatus,
    this.lecturer,
    this.department,
    this.location,
    this.dates,
  ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Course &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location.id;
    tempMap["description"] = this.description;
    tempMap["department"] = this.department.number;
    tempMap["lecturer"] = this.lecturer.id;
    tempMap["room"] = this.room;
    tempMap["courseStatus"] = statusToString(this.courseStatus);
    tempMap["availableSlots"] = this.availableSlots;
    tempMap["ects"] = this.ects;
    tempMap["usCredits"] = this.usCredits;
    tempMap["semesterWeekHours"] = this.semesterWeekHours;

    return tempMap;
  }
  Map<String, dynamic> toFavoritesMap(User user) {
    Map<String, dynamic> tempMap = new Map();
    tempMap['userId'] = user.id;
    tempMap["courseId"] = this.id;
    return tempMap;
  }

  Map<String, dynamic> toSelectedMap(User user) {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location.id;
    tempMap["description"] = this.description;
    tempMap["department"] = this.department.number;
    tempMap["lecturer"] = this.lecturer.id;
    tempMap["room"] = this.room;
    tempMap["courseStatus"] = this.courseStatus == CourseStatus.RED
        ? "red"
        : this.courseStatus == CourseStatus.YELLOW ? "yellow" : "green";
    tempMap["availableSlots"] = this.availableSlots;
    tempMap["ects"] = this.ects;
    tempMap["usCredits"] = this.usCredits;
    tempMap["semesterWeekHours"] = this.semesterWeekHours;
    tempMap["userId"] = user.id;

    return tempMap;
  }

  CustomCourse toCustomCourse(){
    return new CustomCourse(name, location.name, department.number.toString(), lecturer.name, room, dates, custom: false);
  }


}

/// Available course states.
enum CourseStatus { GREEN, YELLOW, RED }

String statusToString(CourseStatus status) {
  if (status == CourseStatus.GREEN) return 'green';
  if (status == CourseStatus.YELLOW) return 'yellow';
  return 'red';
}
