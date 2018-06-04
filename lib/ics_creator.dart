import 'dart:async';
import 'dart:io';

import 'package:courses_in_english/model/course/course.dart';
import 'package:path_provider/path_provider.dart';

String createIcs(List<Course> courses) {
  String result =
      "BEGIN:VCALENDAR\r\nVERSION:2.0\r\nPRODID:CieApp\r\nSUMMARY:Cie Course in at the HM in munich\r\n";
  courses.forEach((c) => result += _createsingleIcs(c));
  result += "END:VCALENDAR\r\n";

  return result;
}

String _createsingleIcs(Course course) {
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
  String result =
      "BEGIN:VEVENT\r\nDTSTART:" + today.year.toString() + day + month + "\r\n";
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
  result += "LOCATION:" + course.location + "\r\n";
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
  c.timeAndDay.forEach((time) {
    result += dayOfWeek[time.day - 1] + ",";
  });
  return result.substring(0, result.length - 1);
}

Future<File> saveIcsFile(List<Course> courses) async {
  String ics = createIcs(courses);
  final file = await _localFile;
  file.writeAsStringSync(ics);
  print(ics);
  return file;
}

Future<String> get _localPath async {
  final directory = await getExternalStorageDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return new File('$path/CiE.ics');
}
