import 'package:courses_in_english/model/course/course.dart';

/// Model for timetable
class TimetableCourse {
  /// Name of the lecturer
  final Course course;
  final int occurrence;

  const TimetableCourse(this.course, this.occurrence);
}
