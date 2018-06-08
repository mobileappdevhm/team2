import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Representation of a course (or lecture).
class Course {
  /// Id of the course
  final int id;

  /// Name (or title) of the course
  final String name;

  /// What is the course about
  final String description;

  /// Where the course will be located
  final String room;

  /// How many slots are available
  final int availableSlots;

  /// ECTS you can get
  final num ects;

  final num usCredits;

  /// SWS, how many hours per weeks
  final num semesterWeekHours;

  final List<TimeAndDay> timeAndDay;

  /// Status of the course
  final CourseStatus status;

  /// Lecturer id
  final Lecturer lecturer;

  /// Department (faculty)
  final Department department;

  /// Location e.g. Pasing
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
    this.timeAndDay,
    this.status,
    this.lecturer,
    this.department,
    this.location,
  ]);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location.id;
    tempMap["description"] = this.description;
    tempMap["department"] = this.department.id;
    tempMap["lecturer"] = this.lecturer.id;
    tempMap["room"] = this.room;
    tempMap["status"] = this.status == CourseStatus.GREEN
        ? "red"
        : this.status == CourseStatus.YELLOW ? "yellow" : "green";
    tempMap["availableSlots"] = this.availableSlots;
    tempMap["ects"] = this.ects;
    tempMap["us"] = this.usCredits;
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
