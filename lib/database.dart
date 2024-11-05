import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class database{

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await create();
      return _db;
    } else {
      return _db;
    }
  }
  Future<Database> create() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'salah.db');
    Database mydb = await openDatabase(
        path, version: 2,onCreate: (Database db, int version) async{
      await db.execute(
          'CREATE TABLE Time (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, subtitle TEXT, time TEXT)');
    });
    return mydb;
  }

  Future<int> InsertData(String title, String subtitle, String time) async {
        Database? mydb=await db;
        int id = await mydb!.rawInsert('INSERT INTO Time(title, subtitle, time) VALUES("$title", "$subtitle","$time" )');
        return id;
  }

  Future<List<Map>> readData() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery("SELECT * FROM Time");
    return response;
  }

  Future<int> deleteData(int id) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete("DELETE FROM Time where id='$id'");
    return response ;
  }

}