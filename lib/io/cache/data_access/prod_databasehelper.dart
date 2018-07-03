import 'dart:async';
import 'dart:io';

import 'package:courses_in_english/io/cache/data_access/databasehelper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdDatabaseHelper implements DatabaseHelper {
  static final ProdDatabaseHelper _instance = new ProdDatabaseHelper.internal();

  factory ProdDatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  ProdDatabaseHelper.internal();

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
        "CREATE TABLE SelectedCourse(id INTEGER PRIMARY KEY, name TEXT, location INTEGER, description TEXT, department INTEGER, lecturer INTEGER, room TEXT, courseStatus TEXT, availableSlots INTEGER, ects REAL, usCredits REAL, semesterWeekHours REAL, userId INTEGER)");
    await db.execute(
        "CREATE TABLE CustomCourse(id INTEGER PRIMARY KEY, name TEXT, location TEXT, department TEXT, lecturer TEXT, room TEXT)");
    await db.execute(
        "CREATE TABLE Department(id INTEGER PRIMARY KEY, number INTEGER, name TEXT, color INTEGER)");
    await db.execute(
        "CREATE TABLE Favorites(id INTEGER PRIMARY KEY, courseId INTEGER)");
    await db.execute(
        "CREATE TABLE Lecturer(id INTEGER PRIMARY KEY, name TEXT, email TEXT)");
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, token TEXT, username TEXT, firstname TEXT, lastname TEXT, department INTEGER)");
    await db.execute(
        "CREATE TABLE Cie(id INTEGER PRIMARY KEY, name TEXT, ects REAL, lecturerName TEXT, department INTEGER)");
    await db.execute(
        "CREATE TABLE Date(id INTEGER PRIMARY KEY, weekday INTEGER, startHour INTEGER, startMinute INTEGER, duration INTEGER, course INTEGER)");
    await db.execute(
        "CREATE TABLE CustomDate(id INTEGER PRIMARY KEY, weekday INTEGER, startHour INTEGER, startMinute INTEGER, duration INTEGER, course INTEGER)");
  }

  @override
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

  @override
  Future<int> insertOneTable(String table, Map<String, dynamic> data) async {
    var dbClient = await db;
    return dbClient.insert(table, data);
  }

  @override
  Future<int> updateTableById(String table, Map<String, dynamic> data,
      String whereColumn, String whereArgs) async {
    var dbClient = await db;

    return dbClient
        .update(table, data, where: '$whereColumn = ?', whereArgs: [whereArgs]);
  }

  @override
  Future<int> truncateUserData() async {
    var dbClient = await db;

    await dbClient.delete("CustomCourse");
    await dbClient.delete("SelectedCourse");
    await dbClient.delete("Favorites");
    await dbClient.delete("User");
    await dbClient.delete("Cie");
    return 0;
  }

  @override
  void truncateAllTable() async {
    var dbClient = await db;
    await dbClient.delete("Campus");
    await dbClient.delete("Course");
    await dbClient.delete("CustomCourse");
    await dbClient.delete("SelectedCourse");
    await dbClient.delete("Department");
    await dbClient.delete("Favorites");
    await dbClient.delete("Lecturer");
    await dbClient.delete("User");
    await dbClient.delete("Cie");
    await dbClient.delete("Date");
    await dbClient.delete("CustomDate");
    exit(0);
  }

  @override
  void truncateTable(String table) async {
    var dbClient = await db;

    await dbClient.delete(table);
  }

  @override
  Future<List<Map<String, dynamic>>> selectTable(String table) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res =
        await dbClient.rawQuery('SELECT * FROM $table');
    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> selectWhere(
      String table, String whereColumn, String whereArgs) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(table,
        columns: null, where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res;
  }

  @override
  Future<Map<String, dynamic>> selectOneWhere(
      String table, String whereColumn, dynamic whereArgs) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(table,
        columns: null, where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res[0];
  }

  @override
  Future<int> deleteWhere(
      String table, String whereColumn, String whereArgs) async {
    var dbClient = await db;
    int res = await dbClient
        .delete(table, where: '$whereColumn = ?', whereArgs: [whereArgs]);
    return res;
  }

  @override
  Future<int> getCount(String table) async {
    var dbClient = await db;
    return Sqflite
        .firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<int> deleteTwoWhere(String table, String whereColumn,
      String whereColumnTwo, String whereArgs, String whereArgsTwo) async {
    var dbClient = await db;
    int res = await dbClient.delete(table,
        where: '$whereColumn = ? AND $whereColumnTwo = ?',
        whereArgs: [whereArgs, whereArgsTwo]);
    return res;
  }
}
