import 'dart:async';

abstract class DatabaseHelper {
  Future<int> insertTable(String table, List<Map<String, dynamic>> dataList);
  Future<int> insertOneTable(String table, Map<String, dynamic> data);
  Future<int> updateTableById(String table, Map<String, dynamic> data,
      String whereColumn, String whereArgs);
  void truncateAllTable();
  Future<List<Map<String, dynamic>>> selectTable(String table);
  Future<List<Map<String, dynamic>>> selectWhere(
      String table, String whereColumn, String whereArgs);
  Future<Map<String, dynamic>> selectOneWhere(
      String table, String whereColumn, String whereArgs);
  Future<int> deleteWhere(String table, String whereColumn, String whereArgs);
  Future<int> getCount(String table);
  void truncateTable(String table);
  Future<int> deleteTwoWhere(String table, String whereColumn, String whereColumnTwo, String whereArgs, String whereArgsTwo);
}
