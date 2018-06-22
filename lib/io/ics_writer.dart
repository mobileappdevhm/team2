import 'dart:async';
import 'dart:io';

import 'package:courses_in_english/model/course/course.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

String createIcs(List<Course> courses) {
  String result =
      "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:CieApp\r\nSUMMARY:Cie Course in at the HM in munich\r\n";
  courses.forEach((c) {
    for (int i = 0; i < c.dates.length; i++) {
      result += _createsingleIcs(c, i);
    }
  });
  result += "END:VCALENDAR\r\n";

  return result;
}

String _createsingleIcs(Course course, int listpos) {
  DateTime today = new DateTime.now();
  String day = today.day.toString();
  String hour = today.hour.toString();
  String minute = today.minute.toString();
  String second = today.second.toString();
  if (day.length == 1) {
    day = "0" + day;
  }
  String month = today.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }
  if (minute.length == 1) {
    minute = "0" + minute;
  }
  if (second.length == 1) {
    second = "0" + second;
  }
  String courshour = course.dates[listpos].startHour.toString();
  if (courshour.length == 1) {
    courshour = "0" + courshour;
  }
  String courseminute = course.dates[listpos].startMinute.toString();
  if (courseminute.length == 1) {
    courseminute = "0" + courseminute;
  }
  String result = "BEGIN:VEVENT\r\nSUMMARY:" +
      course.name +
      "\r\nDTSTART:" +
      today.year.toString() +
      month +
      day +
      "T" +
      courshour +
      courseminute +
      "00" +
      "\r\n";
  result += "UID: CIE" + today.toIso8601String() + "\r\n";
  result += "DTSTAMP:" +
      today.year.toString() +
      day +
      month +
      "T" +
      hour +
      minute +
      second +
      "\r\n";
  result +=
      "RRULE:FREQ=WEEKLY;COUNT=20;WKST=SU;BYDAY=" + _dayshort(course) + "\r\n";
  result += "LOCATION:" + course.location.name + "\r\n";
  result += "END:VEVENT\r\n";

  return result;
}

String _dayshort(Course c) {
  String result = "";
  List<String> dayOfWeek = [
    "MO",
    "TU",
    "WE",
    "TH",
    "FR",
    "SA",
    "SU",
  ];
  c.dates.forEach((time) {
    result += dayOfWeek[time.weekday - 1] + ",";
  });
  return result.substring(0, result.length - 1);
}

saveIcsFile(List<Course> courses) async {
  requestPermission();

  String ics = createIcs(courses);
  final file = await _localFile;
  file.writeAsString(ics);
  print(ics);
}

requestPermission() async {
  bool res = await SimplePermissions
      .requestPermission(Permission.WriteExternalStorage);
  print("permission request result is " + res.toString());
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/CiE.ics');
}

void writeFile(String s) async {
  final file = await _localFile;
  file.writeAsString(s);
}
