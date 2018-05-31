class TimeAndDay {
  final int day;
  final String duration;
  final int hour;
  final int minute;

  const TimeAndDay(this.day, this.duration, this.hour, this.minute);

  String toDate() {
    String date = "";
    List<String> dayOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
    ];
    date = dayOfWeek[day - 1] + " " + duration;
    return date;
  }
}
