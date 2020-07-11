import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'exercise.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_exercises(id TEXT PRIMARY KEY, title TEXT, created_at TEXT, sets INTEGER, repetitions INTEGER, exercise_time TEXT, rest_time TEXT, break_time TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> remove(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(
      table,
      where: 'id = "$id"',
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
