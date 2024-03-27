import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'mybase.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""CREATE TABLE Person(
                                id INTEGER PRIMARY KEY AUTOINCREMENT,
                                name TEXT,
                                phone TEXT,
                        );""");
  }

  Future<void> addPerson(Map<String, dynamic> person) async {
    Database db = await this.database;
    await db.insert("Person", person);
  }

  Future<List<Map<String, dynamic>>> getAllPerson() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> data = await db.query("Person");
    return data;
  }

  Future<List<Map<String, dynamic>>> getPerson(int id) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> data;
    data = await db.query("Person", where:  "id = ?", whereArgs: [id]);
    return data;
  }

  Future<int> deletePerson(int id) async {
    Database db = await this.database;
    return await db.delete("Person", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updatePerson(Map<String, dynamic> person, int id) async {
    Database db = await this.database;
    return await db.update("Person", person, where: "id = ?", whereArgs: [id]);
  }
}