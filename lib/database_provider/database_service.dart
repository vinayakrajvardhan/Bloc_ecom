import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../data/model/product.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'product.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Product('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'description TEXT,'
          'price DOUBLE,'
          'featured_image TEXT'
          ')');
    });
  }

  // Insert product in database
  createProduct(Datum data) async {
    await deleteCart(data.id);
    final db = await database;
    final res = await db.insert('Product', data.toJson());

    return res;
  }

  Future<int> insertUser(Datum data) async {
    final db = await database;
    int result = await db.insert('Product', data.toJson());
    return result;
  }

  // Delete item from cart
  Future<int> deleteCart(int id) async {
    final db = await database;
    final res = await db.delete(
      'Product',
      where: "id = ?",
      whereArgs: [id],
    );

    return res;
  }

  Future<List<Datum>> getAllProduct() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM EMPLOYEE");

    List<Datum> list =
        res.isNotEmpty ? res.map((c) => Datum.fromJson(c)).toList() : [];

    return list;
  }
}
