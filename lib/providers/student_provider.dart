import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models/student_model.dart';


class StudentProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Student> _students = [];

  List<Student> get students => _students;

  Future<void> addStudent(Student student) async {
    await _databaseHelper.insertStudent(student);
    _students = await _databaseHelper.getAllStudents();
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    _students = await _databaseHelper.getAllStudents();
    notifyListeners();
  }

  Future<void> updateStudent(Student student) async {
    await _databaseHelper.updateStudent(student);
    _students = await _databaseHelper.getAllStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await _databaseHelper.deleteStudent(id);
    _students = await _databaseHelper.getAllStudents();
    notifyListeners();
  }
}
