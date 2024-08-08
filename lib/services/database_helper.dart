import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        dueDate INTEGER NOT NULL
      )
    ''');
  }

  Future<List<ToDoItem>> getToDoItems() async {
    final db = await database;
    final maps = await db.query('todos');
    return maps
        .map(
          (map) => ToDoItem(
            id: map['id'] as int,
            title: map['title'] as String,
            description: map['description'] as String? ?? '',
            dueDate: map['dueDate'] != null
                ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] is int
                    ? map['dueDate'] as int
                    : int.tryParse(map['dueDate'] as String) ??
                        DateTime.now().millisecondsSinceEpoch)
                : DateTime.now(),
          ),
        )
        .toList();
  }

  Future<void> insertToDoItem(ToDoItem item) async {
    final db = await database;
    await db.insert('todos', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateToDoItem(ToDoItem item) async {
    final db = await database;
    await db
        .update('todos', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> deleteToDoItem(int id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
