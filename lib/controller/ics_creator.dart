import 'package:courses_in_english/io/ics_writer.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:simple_permissions/simple_permissions.dart';

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
  String result = "BEGIN:VEVENT\r\nSUMMARY:" +
      course.name +
      "\r\nDTSTART:" +
      today.year.toString() +
      day +
      month +
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
  result += "LOCATION:" + course.location.toString() + "\r\n";
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
  writeFile(ics);
}

requestPermission() async {
  bool res = await SimplePermissions
      .requestPermission(Permission.WriteExternalStorage);
  print("permission request result is " + res.toString());
}


