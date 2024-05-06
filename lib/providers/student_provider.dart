import 'package:facial_recognition_app/admin_web/dashboard_screen.dart';
import 'package:facial_recognition_app/api.dart';
import 'package:flutter/material.dart';
import '../database_helper.dart';
// import '../models/student_model.dart';


class StudentProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Student> _students = [];

  List<Student> get students => _students;

  // Future<void> addStudent(Student student) async {
  //   await _databaseHelper.insertStudent(student);
  //   _students = await _databaseHelper.getAllStudents();
  //   notifyListeners();
  // }

  // Future<void> getAllStudents() async {
  //   _students = await _databaseHelper.getAllStudents();
  //   notifyListeners();
  // }

  // Future<void> updateStudent(Student student) async {
  //   await _databaseHelper.updateStudent(student);
  //   _students = await _databaseHelper.getAllStudents();
  //   notifyListeners();
  // }

  // Future<void> deleteStudent(int id) async {
  //   await _databaseHelper.deleteStudent(id);
  //   _students = await _databaseHelper.getAllStudents();
  //   notifyListeners();
  // }


   // Function to delete a student by registration number
  Future<void> deleteStudent(String regNumber, BuildContext context) async {
    try {
      // Call the API method to delete the student
      var res = await CallApi().authenticatedDeleteRequest(regNumber, context: context);
      
      if (res != null) {
        // Remove the student from the local state
        _students?.removeWhere((student) => student.regNumber == regNumber);
        // Notify listeners to update the UI
        notifyListeners();
      } else {
        // Handle error when response is null
      }
    } catch (e) {
      // Handle errors
    }
  }
}

