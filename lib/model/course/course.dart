import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location;
    tempMap["description"] = this.description;
    tempMap["department"] = this.department;
    tempMap["lecturer"] = this.lecturer;
    tempMap["room"] = this.room;
    tempMap["courseStatus"] = this.courseStatus == CourseStatus.RED
        ? "red"
        : this.courseStatus == CourseStatus.YELLOW ? "yellow" : "green";
    tempMap["availableSlots"] = this.availableSlots;
    tempMap["ects"] = this.ects;
    tempMap["usCredits"] = this.usCredits;
    tempMap["semesterWeekHours"] = this.semesterWeekHours;

    return tempMap;
  }
}

/// Available course states.
enum CourseStatus { GREEN, YELLOW, RED }

String statusToString(CourseStatus status) {
  switch (status) {
    case CourseStatus.GREEN:
      return "green";
    case CourseStatus.YELLOW:
      return "yellow";
    case CourseStatus.RED:
      return "red";
  }
  throw new UnimplementedError("Unsupported status");
}

CourseStatus stringToStatus(String status) {
  switch (status.toLowerCase()) {
    case "green":
      return CourseStatus.GREEN;
    case "yellow":
      return CourseStatus.YELLOW;
    case "red":
      return CourseStatus.RED;
  }
  throw new UnimplementedError("No status found for string '$status'.");
}
