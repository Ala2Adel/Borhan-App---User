import 'package:sqflite/sqflite.dart'as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{

  static Future <Database> database() async{
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'fav.db'), onCreate: (db, version)
    {
      return db.execute('CREATE TABLE activity_fav(id TEXT PRIMARY KEY, name TEXT, desc TEXT, image TEXT)');
    }, version: 1);
  }


  static Future<void> insert (String table, Map<String, Object> data) async {
    final db= await DBHelper.database();
        db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }


  static Future<List<Map<String, dynamic>>> getData(String table) async{
    final db= await DBHelper.database();
    return db.query(table);
  }
}
