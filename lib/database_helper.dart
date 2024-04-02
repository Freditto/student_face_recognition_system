import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/student_model.dart';


class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'students';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            regNumber TEXT,
            first_name TEXT,
            last_name TEXT,
            gender TEXT,
            program TEXT,
            class TEXT,
            ntaLevel TEXT,
            picture BLOB,
            isEligible INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return await db.insert(tableName, student.toMap());
  }

  Future<List<Student>> getAllStudents() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return await db.update(
      tableName,
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
