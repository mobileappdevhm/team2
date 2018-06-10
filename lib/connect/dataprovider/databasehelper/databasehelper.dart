import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Campus(id INTEGER PRIMARY KEY, name TEXT, image BLOB, address TEXT)");
    await db.execute(
        "CREATE TABLE Course(id INTEGER PRIMARY KEY, name TEXT, location INTEGER, description TEXT, department INTEGER, lecturer INTEGER, room TEXT, courseStatus TEXT, availableSlots INTEGER, ects REAL, usCredits REAL, semesterWeekHours REAL)");
    await db.execute(
        "CREATE TABLE Department(id INTEGER PRIMARY KEY, number INTEGER, name TEXT, color TEXT)");
    await db.execute(
        "CREATE TABLE Favorites(id INTEGER PRIMARY KEY, classname TEXT, note TEXT)");
    await db.execute(
        "CREATE TABLE Lecturer(id INTEGER PRIMARY KEY, name TEXT, email TEXT, courseID INTEGER)");
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, firstname TEXT, lastname TEXT, department INTEGER)");
    await db.execute(
        "CREATE TABLE Cie(id INTEGER PRIMARY KEY, name TEXT, ects REAL, lecturerName TEXT, department INTEGER)");
    await db.execute(
        "CREATE TABLE Date(id INTEGER PRIMARY KEY, weekday INTEGER, startHour INTEGER, startMinute INTEGER, duration INTEGER, course INTEGER)");
  }

  Future<int> insertTable(
      String table, List<Map<String, dynamic>> dataList) async {
    var dbClient = await db;
    int returnValue = 0;

    void iterate(Map<String, dynamic> data) async {
      int tempReturnValue = await dbClient.insert(table, data);
      tempReturnValue == 0 ? null : returnValue = tempReturnValue;
    }

    dataList.forEach(iterate);

    return returnValue;
  }

  Future<int> truncateTable(String table) async {
    var dbClient = await db;

    return await dbClient.delete(table);
  }

  Future<List<Map<String, dynamic>>> selectTable(String table) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res =
        await dbClient.rawQuery('SELECT * FROM $table');
    return res;
  }

  Future<List<Map<String, dynamic>>> selectWhere(
      String table, String whereColumn, String whereArgs) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(table,
        columns: ["*"], where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res;
  }

  Future<Map<String, dynamic>> selectOneWhere(
      String table, String whereColumn, String whereArgs) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(table,
        columns: ["*"], where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res[0];
  }

  Future<int> deleteWhere(
      String table, String whereColumn, String whereArgs) async {
    var dbClient = await db;
    int res = await dbClient
        .delete(table, where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res;
  }
}
