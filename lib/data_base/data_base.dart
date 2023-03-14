// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:add_card/card/add_card_screen/add_card_screen.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  final _databaseName = "card.db";
  final _databaseVersion = 1;
  static const table = 'cardAdd';
  final id = 'id';
  final cardNumber = 'cardNumber';
  final cardDate = 'expiresDate';
  final cardImage = 'image';
  final cardName = 'name';

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();
  Database? _database;

  factory DatabaseHelper() => instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, _databaseName);

    // SQL code to create the database table
    var db =
        await openDatabase(path, version: _databaseVersion, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $cardNumber TEXT,
            $cardDate TEXT,
            $cardImage TEXT,
            $cardName TEXT
          )
          ''');
  }

  Future insert(CardModel cardModel) async {
    final db = await database;
    var res = await db.insert(table, cardModel.toJson());
    return res;
  }

  Future<List<CardModel>> getBasketProducts() async {
    var dbClient = await database;
    List<Map> list = await dbClient.rawQuery('select *from $table');
    List<CardModel> products = [];
    for (int i = 0; i < list.length; i++) {
      var items = CardModel(
          cardNumber: list[i][cardNumber],
          expiresDate: list[i][cardDate],
          image: list[i][cardImage],
          name: list[i][cardName]
      );
      products.add(items);
    }
    return products;
  }

  Future<void> clearTable(String table) async {
    var db = await database;
    await db.rawQuery("DELETE FROM $table");
  }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }
}
