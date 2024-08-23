import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DataBaseBooks{
  late Future<Database> database;
  initDB() async {
   return openDatabase(
    join(await getDatabasesPath(), 'books.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE books(id INTEGER PRIMARY KEY, name TEXT)',
      );
    },

    version: 1,
  );
}
Future<void> insertBook(data) async {
  final db = await initDB();
  await db.insert(
    'books',
    data,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<dynamic>> getBooks() async {
  final db = await initDB();

  final List<Map<String, Object?>> books = await db.query('books');

  return books;
}
}

