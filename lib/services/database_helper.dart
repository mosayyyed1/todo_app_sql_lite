import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dueDate INTEGER NOT NULL
      )
    ''');
  }

  Future<void> insertToDoItem(ToDoItem item) async {
    final db = await instance.database;
    await db.insert('todos', item.toMap());
  }

  Future<List<ToDoItem>> getToDoItems() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((json) => ToDoItem.fromMap(json)).toList();
  }

  Future<void> deleteToDoItem(int id) async {
    final db = await instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
