import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// table and column name
final String tableUser = 'User';
final String columnId = '_id';
final String columnUserName = 'username';
final String columnPassword = 'done';

class DatabaseHelper {
  static Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }

    _db = await initDb();
    return db;
  }

  initDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'main.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  
  void _onCreate(Database db, int version) async {
    await db.execute(
        'create table $tableUser ($columnId integer primary key autoincrement,'
            '$columnUserName text not null, $columnPassword text not null)');
  }

  Future close() async => _db.close();
}
