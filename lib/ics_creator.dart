import 'package:courses_in_english/connect/dataprovider/data.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';

String createIcs(List<Course> courses){
  String result = "BEGIN:VCALENDAR\r\n VERSION:2.0\r\nPRODID:CieApp\r\nSUMMARY:Cie Course in at teh HM in munich\r\n";
  courses.forEach((c) =>result+= _createsingleIcs(c));
  result += "END:VEVENT\r\nEND:VCALENDAR\r\n";

  return "";
}
String _createsingleIcs(Course course){
  DateTime today = new DateTime.now();
  String day = today.day.toString();
  if(day.length ==1){
    day = "0"+ day;
  }
  String month = today.month.toString();
  if(month.length ==1){
    month = "0"+ month;
  }
  String result = "DTSTART:"+ today.year.toString()+day +month + today.hour.toString()+today.minute.toString()+ "\r\n";
  result+= "RRULE:FREQ=WEEKLY;COUNT=20;WKST=SU;BYDAY=" +_dayshort(course)+ "\r\n";
  result += "LOCATION:" + course.location+ "\r\n";


  return result;
}
String _dayshort(Course c){
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
  return result.substring(0,result.length-1);
}
