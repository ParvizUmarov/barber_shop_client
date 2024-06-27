
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/entity/user.dart';

class DB{
  static Database? _db;
  static final DB instance = DB._constructor();

  DB._constructor();

  final String _userTable = "user";
  final String _userId = "uid";
  final String _userMail = "mail";
  final String _userToken = "token";
  final String _userType = "type";

  Future<Database> get database async {
     if(_db != null) return _db!;
     _db = await getDatabase();
     return _db!;
  }


  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "barbershop_db.db");
    final database = await openDatabase(
        databasePath,
        version: 1,
        onCreate: (db, version){
          db.execute('''
          CREATE TABLE $_userTable (
            $_userId INTEGER PRIMARY KEY,
            $_userMail TEXT NOT NULL,
            $_userToken TEXT NOT NULL,
            $_userType TEXT NOT NULL
          )
          ''');
        }
    );
    return database;
  }


  void addUser(Users user, String userType) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(_userTable, where: '$_userType = ?', whereArgs: ["CUSTOMER"]);
      await txn.delete(_userTable, where: '$_userType = ?', whereArgs: ["BARBER"]);
      await txn.insert(_userTable, {
        _userId: user.uid,
        _userMail: user.mail,
        _userToken: user.token,
        _userType: userType
      });
    });
    log("SQFlite: add user ${user.mail}=${user.type} ");
  }

  Future<Users?> getUser(String token) async {
    final db = await database;
    var res = await db.query(_userTable, where: "token = ?", whereArgs: [token]);
    return res.isNotEmpty ? Users.fromJson(res.first) : null;
  }

  Future<Users?> getUserInfo() async {
    final db = await database;
    var res = await db.query(_userTable);
    return res.isNotEmpty ? Users.fromJson(res.first) : null;
  }


  deleteUser(String type) async {
    final db = await database;
    await db.delete(_userTable, where: "type = ?", whereArgs: [type]);
    log("SQFlite: delete $type");
  }

}