import 'dart:async';

import 'package:framework/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProxy extends Proxy {
  static const String NAME = "DatabaseProxy";

  late Database _database;

  DatabaseProxy() : super(NAME) {
    print(">\t DatabaseProxy -> instance created");
  }

  @override
  void onRegister() {
    print(">\t DatabaseProxy -> onRegister");
  }

  @override
  void onRemove() {}

  Future createDatabase(Type vo, Map<String, String> params, [bool autoincrementID = true]) async {
    String query =
        "CREATE TABLE IF NOT EXISTS ${vo.toString()} (id INTEGER PRIMARY KEY ${autoincrementID ? "AUTOINCREMENT" : ""}, ";
    List<String> keyTypes = List<String>.empty(growable: true);
    params.forEach((key, type) => keyTypes.add("$key $type"));
    query += keyTypes.join(",");
    print(">\t DatabaseProxy -> createDatabase > query: " + query);
    await _database.execute(query + ");");
  }

  Future deleteDatabase(Type vo) async {
    String query = "DROP TABLE IF EXISTS ${vo.toString()};";
    print(">\t DatabaseProxy -> deleteDatabase > query: " + query);
    await _database.execute(query);
  }

  Future<List<Map>> retrieveVO(Type vo) async {
    String query = "SELECT * FROM ${vo.toString()} ORDER BY ROWID ASC LIMIT 1;";
    print(">\t DatabaseProxy -> retrieveVO > query: " + query);
    return await _database.rawQuery(query);
  }

  Future<List<Map>> retrieve(Type vo, {int limit = -1}) async {
    String query = "SELECT * FROM ${vo.toString()} ORDER BY ROWID ${limit > 0 ? "LIMIT 1" : ""};";
    print(">\t DatabaseProxy -> retrieve > query: " + query);
    return await _database.rawQuery(query);
  }

  Future deleteItemWithID(Type vo, {int? id}) async {
    String query = "DELETE FROM ${vo.toString()} WHERE id = \'$id\';";
    print(">\t DatabaseProxy -> deleteAtIndex > query: " + query);
    return await _database.rawQuery(query);
  }

  Future insertVO(Type vo, Map<String, Object> params) async {
    print(">\t DatabaseProxy -> insertVO > params: " + params.toString());
    String query = "INSERT INTO ${vo.toString()} (";
    List<String> keys = List<String>.empty(growable: true);
    List<Object> values = List<Object>.empty(growable: true);
    params.forEach((key, value) {
      keys.add(key);
      values.add(value);
    });
    query += "${keys.join(",")}) VALUES(\'${values.join("\',\'")}\')";
    print(">\t DatabaseProxy -> insertVO > query: " + query);
    return await _database.rawQuery(query);
  }

  Future updateVO(Type vo, {required Map<String, Object> params, int? id}) async {
    print(">\t DatabaseProxy -> updateVO > params: " + params.toString());
    String query = "UPDATE ${vo.toString()} SET ";
    List<String> keysValues = List<String>.empty(growable: true);
    params.forEach((key, value) {
      keysValues.add("$key=\'$value\'");
    });
    query += "${keysValues.join(",")} WHERE id=$id";
    print(">\t DatabaseProxy -> updateVO > query: " + query);
    return await _database.rawQuery(query);
  }

  Future init() async {
    const databaseName = "app.db";
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseName);

    print(">\t DatabaseProxy -> init > openDatabase: path = " + path);
    _database = await openDatabase(path, version: 1, onCreate: (db, int version) {
      print(">\t DatabaseProxy -> init > database: onCreate");
    }, onOpen: (db) {
      print(">\t DatabaseProxy -> init > database: onOpen");
    });
  }
}
