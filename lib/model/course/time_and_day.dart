import 'package:courses_in_english/model/user/user.dart';

class TimeAndDay {
  final int id;

  /*
   * Week day in range [1, 7] where 1 is monday and 7 is sunday.
   */
  final int weekday;

  /*
   * Start hour in range [0, 24].
   */
  final int startHour;

  /*
   * Start minute in range [0, 59].
   */
  final int startMinute;

  /*
   * Duration of the course appointment in minutes.
   */
  final int duration;

  final int course;

  const TimeAndDay(this.id, this.weekday, this.startHour, this.startMinute,
      this.duration, this.course);

  String toDate() {
    String date = "";
    var nowTime = new DateTime.now();
    var startTime = new DateTime(nowTime.year, nowTime.month, nowTime.month,
        weekday, startHour, startMinute);
    var endTime = new DateTime(nowTime.year, nowTime.month, nowTime.month,
            weekday, startHour, startMinute)
        .add(new Duration(minutes: duration));
    List<String> dayOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    date = dayOfWeek[weekday] +
        " " +
        startTime.hour.toString() +
        ":" +
        startTime.minute.toString() +
        " - " +
        endTime.hour.toString() +
        ":" +
        endTime.minute.toString();
    return date;
  }

  String getStringDay() {
    List<String> dayOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return dayOfWeek[weekday];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tempMap = new Map();

//    tempMap['id'] = this.id;
    tempMap["weekday"] = this.weekday;
    tempMap["startHour"] = this.startHour;
    tempMap["startMinute"] = this.startMinute;
    tempMap["duration"] = this.duration;
    tempMap["course"] = this.course;

    return tempMap;
  }

  Map<String, dynamic> toCustomMap(User user) {
    Map<String, dynamic> tempMap = new Map();

//    tempMap['id'] = this.id;
    tempMap["weekday"] = this.weekday;
    tempMap["startHour"] = this.startHour;
    tempMap["startMinute"] = this.startMinute;
    tempMap["duration"] = this.duration;
    tempMap["course"] = this.course;
    tempMap["userId"] = user.id;

    return tempMap;
  }
}
