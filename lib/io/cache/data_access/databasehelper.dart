import 'dart:async';

abstract class DatabaseHelper {
  Future<int> insertTable(String table, List<Map<String, dynamic>> dataList);

  Future<int> insertOneTable(String table, Map<String, dynamic> data);

  Future<int> updateTableById(String table, Map<String, dynamic> data,
      String whereColumn, dynamic whereArgs);

  void truncateAllTable();

  void truncateTable(String table);

  Future<int> truncateUserData();

  Future<List<Map<String, dynamic>>> selectTable(String table);

  Future<List<Map<String, dynamic>>> selectWhere(
      String table, String whereColumn, dynamic whereArgs);

  Future<Map<String, dynamic>> selectOneWhere(
      String table, String whereColumn, dynamic whereArgs);

  Future<int> deleteWhere(String table, String whereColumn, dynamic whereArgs);

  Future<int> getCount(String table);

  Future<int> deleteTwoWhere(String table, String whereColumn,
      String whereColumnTwo, dynamic whereArgs, dynamic whereArgsTwo);

  Future<int> getCountWhere(String table, String whereColumn, dynamic whereArgs);
}
