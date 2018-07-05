import 'dart:async';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:courses_in_english/io/cache/providers/lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class SqliteLecturerProvider implements CacheLecturerProvider {
  final DatabaseHelper dbh;

  SqliteLecturerProvider(this.dbh);

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    Map<String, dynamic> lecturerData =
        await dbh.selectOneWhere("Lecturer", "id", lecturerId);
    Lecturer tempLecturer = new Lecturer(
        lecturerData["id"], lecturerData["name"], lecturerData["email"]);
    return new Future(() => tempLecturer);
  }

  @override
  Future<List<Lecturer>> getLecturers() async {
    List<Map<String, dynamic>> lecturerData = await dbh.selectTable("Lecturer");
    List<Lecturer> lecturers = [];

    void addLecturer(Map<String, dynamic> data) {
      Lecturer tempLecturer =
          new Lecturer(data["id"], data["name"], data["email"]);

      lecturers.add(tempLecturer);
    }

    lecturerData.forEach(addLecturer);

    return new Future(() => lecturers);
  }

  @override
  Future<int> putLecturers(List<Lecturer> lecturers) async {
    int count = await dbh.getCount("Lecturer");
    if (count != lecturers.length) {
      List<Map<String, dynamic>> lecturerList = [];

      void iterate(Lecturer data) {
        lecturerList.add(data.toMap());
      }

      lecturers.forEach(iterate);

      return dbh.insertTable("Lecturer", lecturerList);
    } else {
      return 0;
    }
  }

  Future<int> truncate() {
    dbh.truncateTable("Lecturer");
    return new Future(() => 0);
  }
}
