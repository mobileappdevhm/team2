import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/lecturer/lecturer_provider.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';
import 'package:courses_in_english/connect/dataprovider/databasehelper/databasehelper.dart';

/// Mock lecturer provider providing lecturers from the mock courses.
class SqliteLecturerProvider implements LecturerProvider {

  @override
  Future<Lecturer> getLecturerById(int lecturerId) async {
    DatabaseHelper dbh = new DatabaseHelper();
    Map<String, dynamic> lecturerData = await dbh.selectOneWhere("Lecturer", "id", lecturerId.toString());
    Lecturer tempLecturer = new Lecturer(lecturerData["id"], lecturerData["name"], lecturerData["email"]);
    return new Future.delayed(const Duration(milliseconds: 200),
            () => tempLecturer);
  }
}
