import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';

/// Representation of a course (or lecture).
class Course {
  /// Id of the course
  final int id;

  /// Name (or title) of the course
  final String name;

  /// Location e.g. Pasing
  final String location;

  /// What is the course about
  final String description;

  /// Department (faculty) number
  final int department;

  /// Lecturer id
  final int lecturerId;

  /// Lecturer name
  final String lecturerName;

  /// Where the course will be located
  final String room;

  /*
  ADDITIONAL INFORMATION.
   */

  /// Status of the course
  final CourseStatus status;

  /// TODO What is this?
  final List<int> courseFacultyAvailable;

  /// How many slots are available
  final int availableSlots;

  /// ECTS you can get
  final num ects;

  /// SWS, how many hours per weeks
  final num semesterWeekHours;

  final TimeAndDay timeAndDay;

  const Course(
      this.id,
      this.name,
      this.location,
      this.description,
      this.department,
      this.lecturerId,
      this.lecturerName,
      this.room,
      this.status,
      this.courseFacultyAvailable,
      this.availableSlots,
      this.ects,
      this.semesterWeekHours,
      this.timeAndDay);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

    tempMap['id'] = this.id;
    tempMap["name"] = this.name;
    tempMap["location"] = this.location;
    tempMap["description"] = this.description;
    tempMap["department"] = this.department;
    tempMap["lecturerId"] = this.lecturerId;
    tempMap["lecturerName"] = this.lecturerName;
    tempMap["room"] = this.room;
    tempMap["status"] = this.status == CourseStatus.GREEN
        ? "red"
        : this.status == CourseStatus.YELLOW ? "yellow" : "green";
    tempMap["courseFacultyAvailable"] = this.courseFacultyAvailable.join(",");
    tempMap["availableSlots"] = this.availableSlots;
    tempMap["ects"] = this.ects;
    tempMap["semesterWeekHours"] = this.semesterWeekHours;
    tempMap["day"] = this.timeAndDay.day;
    tempMap["duration"] = this.timeAndDay.duration;
    tempMap["slot"] = this.timeAndDay.slot;

    return tempMap;
  }
}
