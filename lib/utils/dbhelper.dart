// import 'dart:io';
// import 'package:firestore_auth/class/contact.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static const _dbName = "ContactDatabase.db";
//   static const _dbVersin = 1;

//   //Singleton class
//   DatabaseHelper._();
//   static final DatabaseHelper instance = DatabaseHelper._();

//   Database _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await _initDatabase();
//     return _database;
//   }

//   _initDatabase() async {
//     Directory dbDirectory = await getApplicationDocumentsDirectory();
//     String dbPath = join(dbDirectory.path, _dbName);
//     print(dbPath);
//     return await openDatabase(dbPath,
//         version: _dbVersin, onCreate: _onCreateDb);
//   }

//   Future _onCreateDb(Database db, int version) async {
//     //create table
//     await db.execute('''
//     CREATE TABLE ${Contact.tblname}(
//           ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
//           ${Contact.colName} text not null,
//           ${Contact.colPhone} text not null,
//         )
//     ''');
//   }

//   //CRUD operation

//   Future<int> insertContact(Contact contact) async {
//     Database db = await database;
//     return await db.insert(Contact.tblname, contact.toMap());
//   }

// //update
//   Future<int> updatecontact(Contact contact) async {
//     Database db = await database;
//     return await db.update(Contact.tblname, contact.toMap(),
//         where: '${Contact.colId}=?', whereArgs: [contact.id]);
//   }

//   //delete

//   Future<int> deleteContact(int id) async {
//     Database db = await database;
//     return await db
//         .delete(Contact.tblname, where: '${Contact.colId}=?', whereArgs: [id]);
//   }

//   //fetch
//   Future<List<Contact>> fetchContacts() async {
//     Database db = await database;
//     List<Map> contacts = await db.query(Contact.tblname);
//     return contacts.length == 0
//         ? []
//         : contacts.map((e) => Contact.fromMap(e)).toList();
//   }
// }

import 'dart:io';

import 'package:firestore_auth/class/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'ContactDatabase.db';
  static const _databaseVersion = 1;

  //singleton class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    print(dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    await db.execute('''
      CREATE TABLE ${Contact.tblname}(
        ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colPhone} TEXT NOT NULL,
        ${Contact.colEmail} TEXT NOT NULL

      )
      ''');
  }

  //contact - insert
  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblname, contact.toMap());
  }

//contact - update
  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update(Contact.tblname, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs: [contact.id]);
  }

//contact - delete
  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db
        .delete(Contact.tblname, where: '${Contact.colId}=?', whereArgs: [id]);
  }

//contact - retrieve all
  Future<List<Contact>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.tblname);
    return contacts.length == 0
        ? []
        : contacts.map((x) => Contact.fromMap(x)).toList();
  }
}
