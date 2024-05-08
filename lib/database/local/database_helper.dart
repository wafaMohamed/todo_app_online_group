import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo_database.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        dateTime TEXT
      )
    ''');
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    Database db = await database;
    return await db.query('todos');
  }

  Future<List<Todo>> getTodoList() async {
    List<Map<String, dynamic>> todoMaps = await getTodos();
    return List.generate(todoMaps.length, (i) {
      return Todo(
        id: todoMaps[i]['id'],
        name: todoMaps[i]['name'],
        description: todoMaps[i]['description'],
        dateTime: DateTime.parse(todoMaps[i]['dateTime']),
      );
    });
  }

  Future<void> updateTodo(Todo todo) async {
    Database db = await database;
    await db
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(int id) async {
    Database db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
