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
}

/// Available course states.
enum CourseStatus { GREEN, YELLOW, RED }

String statusToString(CourseStatus status) {
  if (status == CourseStatus.GREEN) return 'GREEN';
  if (status == CourseStatus.YELLOW) return 'YELLOW';
  return 'RED';
}

CourseStatus stringToStatus(String status) {
  if (status.toUpperCase() == 'GREEN') return CourseStatus.GREEN;
  if (status.toUpperCase() == 'YELLOW') return CourseStatus.YELLOW;
  return CourseStatus.RED;
}
