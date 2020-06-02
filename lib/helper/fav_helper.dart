import 'package:sqflite/sqflite.dart'as sql;
import 'package:path/path.dart' as path;

class DBHelper{
  
  static Future<void> insert (String table, Map<String, Object>data) async {
    final dbPath = await sql.getDatabasesPath();

    //db is created when no db is found.

    sql.openDatabase(path.join(dbPath, 'fav.db'), onCreate: (db, version)
    {
     return db.execute('CREATE TABLE activity_fav(id TEXT PRIMARY KEY,  name TEXT, desc TEXT, image TEXT)');
    }, version: 1);
        
    
  }
}
