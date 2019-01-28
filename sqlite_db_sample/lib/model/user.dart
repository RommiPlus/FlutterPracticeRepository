import 'package:sqlite_db_sample/data/database_helper.dart';

class User {
  int id;
  String username;
  String password;

  User(this.username, this.password, {this.id});

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    username = map[columnUserName];
    password = map[columnPassword];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUserName: username,
      columnPassword: password
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
