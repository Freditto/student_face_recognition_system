import 'package:facial_recognition_app/screens/add_student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student_model.dart';
import '../providers/student_provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    studentProvider.getAllStudents();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: studentProvider.students.isEmpty
          ? Center(
              child: Text('No students available'),
            )
          : ListView.builder(
              itemCount: studentProvider.students.length,
              itemBuilder: (context, index) {
                final student = studentProvider.students[index];
                return GestureDetector(
                  onTap: () {
                    // Handle tap event if needed
                  },
                  onLongPress: () {
                    _showOptionsDialog(context, student);
                  },
                  child: ListTile(
                    leading: student.picture != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(student.picture!),
                          )
                        : null, // Display student's image as a circle avatar
                    title: Text(student.first_name!),
                    subtitle: Text(student.regNumber!),
                    // Add more details as needed
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentScreen()),
          );
          // showDialog(
          //   context: context,
          //   builder: (context) => _buildAddStudentDialog(context, null),
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Delete'),
                onTap: () {
                  // Delete the student
                  Provider.of<StudentProvider>(context, listen: false)
                      .deleteStudent(student.id!); // Pass the student's id
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ListTile(
                title: Text('Update'),
                onTap: () {
                  // Navigate to the screen for updating the student
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to the update screen and pass the student object
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         UpdateStudentScreen(student: student),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
