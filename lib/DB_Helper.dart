import 'package:flutter_todoapp/Models/Taskmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String tablename = "TaskDB";

  static Future<void> initdb() async {
    if (_db != null) {
      print("already created");
    }

    try {
      print("creating new one");
      String path = "${await getDatabasesPath()}TaskDB.db";
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tablename("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title STRING, note STRING, date STRING, "
          "starttime STRING, endtime STRING,"
          "remind INTEGER, repeat STRING, "
          "color INTEGER , "
          "iscompleted INTEGER)",
        );
      });
    } catch (e) {
      print("${e}Error in Database initialization");
    }
  }

  static Future<int> insertintoDatabase(Task? task) async {
    // var value =task!.toJson();
    return await _db!.insert(tablename, task!.toMap());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(tablename);
  }

  static deletefromDB(Task task) async {
    await _db!.delete(tablename, where: "id=?", whereArgs: [task.id]);
  }

  static updateDBtask(int id) async {
    return await _db!.rawUpdate('''
UPDATE TaskDB
SET iscompleted = ?
WHERE id = ?

''', [1, id]);
  }
}
