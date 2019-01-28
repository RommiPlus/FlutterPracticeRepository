

import 'package:sqflite/sqflite.dart';
import 'package:sqlite_db_sample/data/database_helper.dart';
import 'package:sqlite_db_sample/model/user.dart';

class UserInfo {
  Database _db;

  UserInfo(this._db);

  Future<int> insert(User user) async {
    int id = await _db.insert(tableUser, user.toMap());
    return id;
  }

  Future<User> get(String username) async {
    List<Map> maps = await _db.query(tableUser,
        columns: [columnId, columnUserName, columnPassword],
        where: '$columnUserName = ?',
        whereArgs: [username]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await _db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return await _db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }
}