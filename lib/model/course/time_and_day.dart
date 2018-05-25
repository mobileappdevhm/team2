class TimeAndDay {
  final int day;
  final String duration;
  final int slot;

  const TimeAndDay(this.day, this.duration, this.slot);

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
