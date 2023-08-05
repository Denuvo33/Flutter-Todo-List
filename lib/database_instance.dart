import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'todo_model.dart';

class DatabaseInstance {
  final String _databaseName = 'my_database.db';
  final int _version = 1;

  //Todo Table
  String tableName = 'Todo';
  String id = 'id';
  String title = 'title';
  String desc = 'desc';
  String createdAt = 'created_at';
  String updatedAt = 'updated_at';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return openDatabase(path, version: _version, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $title TEXT NULL, $desc TEXT NULL, $createdAt TEXT NULL, $updatedAt TEXT NULL )');
  }

  Future<List<TodoList>> all() async {
    final data = await _database!.query(tableName);
    List<TodoList> result = data.map((e) => TodoList.fromJson(e)).toList();

    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableName, row);
    return query;
  }

  Future<int> update(int idParam, Map<String, dynamic> row) async {
    final query = await _database!
        .update(tableName, row, where: ' $id = ? ', whereArgs: [idParam]);
    return query;
  }

  Future delete(int idParam) async {
    await _database!
        .delete(tableName, where: ' $id = ? ', whereArgs: [idParam]);
  }
}
