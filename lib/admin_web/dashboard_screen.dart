import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:facial_recognition_app/admin_web/admin_login_screen.dart';
import 'package:facial_recognition_app/api.dart';
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
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  List<Student>? studentDataList;

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    fetchStudentData(context); // Call fetchStudentData here
    super.initState();
  }

  fetchStudentData(BuildContext context) async {
    String url =
        'get_records'; // Adjust the URL to match the endpoint for fetching students
    var res = await CallApi().authenticatedGetRequest(url, context: context);
    print('*' * 10);
    print('Response');
    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      var studentRecords = body[
          'data']; // Assuming 'records' contains an array of student records
      List<Student> students = [];

      for (var record in studentRecords) {
        Student student = Student.fromMap(record);
        students.add(student);
      }
      print('Length');
      print(students.length);
      setState(() {
        // Set the state with the fetched student data
        studentDataList = students;
        // next = body['next']; // Update pagination parameter if needed
        // waiting_scroll_request = false;
      });
    } else {
      // Handle case when response is null (no network, error, etc.)
      // showSnack(context, 'No network');
      return [];
    }
  }

  deleteStudent(String regNumber) async {
    try {
      // Prepare the FormData request
      FormData formData = FormData.fromMap({
        "registration": regNumber, // Pass the registration number
      });

      // Make the POST request to delete the student
      // var response = await Dio().post('delete_record', data: formData);

      var res =
          await CallApi().authenticatedUploadRequest(formData, 'delete_record');

      // Check if the request was successful (status code 200)
      if (res.statusCode == 200) {
        // Student deleted successfully
        print('Student deleted successfully');
        // Update UI or perform any necessary actions after deletion
        setState(() {});
      } else {
        // Handle other status codes if needed
        print('Failed to delete student');
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error deleting student: $e');
    }
  }

  _logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: const Text(
                    "Are you sure you want to logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () async {
                            // SharedPreferences preferences =
                            //     await SharedPreferences.getInstance();
                            // await preferences.clear();
                            Navigator.of(context).pop();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminLoginScreen()),
                              (route) =>
                                  false, // Prevents navigating back to the previous route
                            );
                          },
                          child: const Text('Yes')),

                      const SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.grey[200]
            ),
            title: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 150,
                    maxWidth: 150,
                  ),
                  child: Image.asset(
                    'assets/loggz.png',
                  ),
                ),
                const Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'Student face recognition',
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                title: 'Students',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                title: 'Exit',
                icon: Icon(Icons.exit_to_app),
                onTap: (index, _) {
                  _logoutDialog(context);
                },
              ),
            ],
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                WebDashboard(
                  totalStudents: 1000, // Provide the total number of students
                  eligibleStudents:
                      750, // Provide the number of eligible students
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          'Student List',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: studentDataList?.length ??
                              1, // Show loader if data is not available
                          itemBuilder: (context, index) {
                            if (studentDataList == null) {
                              // Display loader if data is not yet available
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              );
                            } else {
                              final student = studentDataList![index];
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
                                          backgroundImage:
                                              MemoryImage(student.picture!),
                                        )
                                      : null,
                                  title: Text(
                                      '${student.first_name} ${student.last_name}'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Reg Number: ${student.regNumber}'),
                                      Text(
                                          'Eligibility: ${student.isEligible != null ? (student.isEligible! ? 'Eligible' : 'Not Eligible') : 'Unknown'}'),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {
                                      _showStudentDetailsDialog(context, student);
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentScreen()),
          );
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
                  deleteStudent(student.regNumber!);
                  // Provider.of<StudentProvider>(context, listen: false)
                  //     .deleteStudent(
                  //         student.regNumber!, context); // Pass the student's id
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ListTile(
                title: Text('Update'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStudentDetailsDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('First Name: ${student.first_name}'),
              Text('Last Name: ${student.last_name}'),
              Text('Registration Number: ${student.regNumber}'),
              Text('Gender: ${student.gender}'),
              Text('Program: ${student.program}'),
              // Text('Class: ${student.studentClass}'),
              Text('NTA Level: ${student.ntaLevel}'),
              Text(
                  'Eligibility: ${student.isEligible != null ? (student.isEligible! ? 'Eligible' : 'Not Eligible') : 'Unknown'}'),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Student {
  String? regNumber; // Registration number
  String? first_name;
  String? last_name;
  String? gender;
  String? program;
  // String? studentClass;
  String? ntaLevel;
  Uint8List? picture; // Student picture as byte array
  bool? isEligible;

  Student({
    this.regNumber,
    this.first_name,
    this.last_name,
    this.gender,
    this.program,
    // this.studentClass,
    this.ntaLevel,
    this.picture,
    this.isEligible,
  });

  // Create a Student object from a Map object.
  Student.fromMap(Map<String, dynamic> map) {
    regNumber = map['registration'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    gender = map['gender'];
    program = map['program'];
    // studentClass = map['class'];
    ntaLevel = map['nta_level'];
    isEligible = map['is_eligible'] == "True";
    picture = base64Decode(map['image']);
  }
}

class WebDashboard extends StatelessWidget {
  final int totalStudents;
  final int eligibleStudents;

  WebDashboard({
    required this.totalStudents,
    required this.eligibleStudents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Dashboard Overview',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoCard(
                  title: 'Total Students',
                  value: totalStudents.toString(),
                  color: Colors.blue,
                ),
                _buildInfoCard(
                  title: 'Eligible Students',
                  value: eligibleStudents.toString(),
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Chart Widget Placeholder',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
