import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:facial_recognition_app/admin_web/admin_login_screen.dart';
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

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
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
    final studentProvider = Provider.of<StudentProvider>(context);

    studentProvider.getAllStudents();

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
              // SideMenuExpansionItem(
              //   title: "Expansion Item",
              //   icon: const Icon(Icons.kitchen),
              //   children: [
              //     SideMenuItem(
              //       title: 'Expansion Item 1',
              //       onTap: (index, _) {
              //         sideMenu.changePage(index);
              //       },
              //       icon: const Icon(Icons.home),
              //       badgeContent: const Text(
              //         '3',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       tooltipContent: "Expansion Item 1",
              //     ),
              //     SideMenuItem(
              //       title: 'Expansion Item 2',
              //       onTap: (index, _) {
              //         sideMenu.changePage(index);
              //       },
              //       icon: const Icon(Icons.supervisor_account),
              //     )
              //   ],
              // ),
              // SideMenuItem(
              //   title: 'Files',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.file_copy_rounded),
              //   trailing: Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.amber,
              //           borderRadius: BorderRadius.all(Radius.circular(6))),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 6.0, vertical: 3),
              //         child: Text(
              //           'New',
              //           style: TextStyle(fontSize: 11, color: Colors.grey[800]),
              //         ),
              //       )),
              // ),
              // SideMenuItem(
              //   title: 'Download',
              //   onTap: (index, _) {
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.download),
              // ),
              // SideMenuItem(
              //   builder: (context, displayMode) {
              //     return const Divider(
              //       endIndent: 8,
              //       indent: 8,
              //     );
              //   },
              // ),
              SideMenuItem(
                title: 'Settings',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.settings),
              ),
              // SideMenuItem(
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              //   icon: const Icon(Icons.image_rounded),
              // ),
              // SideMenuItem(
              //   title: 'Only Title',
              //   onTap:(index, _){
              //     sideMenu.changePage(index);
              //   },
              // ),
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
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Dashboard',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                studentProvider.students.isEmpty
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
                                      backgroundImage:
                                          MemoryImage(student.picture!),
                                    )
                                  : null, // Display student's image as a circle avatar
                              title: Text(student.first_name!),
                              subtitle: Text(student.regNumber!),
                              // Add more details as needed
                            ),
                          );
                        },
                      ),

                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Expansion Item 1',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Expansion Item 2',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Files',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Download',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),

                // this is for SideMenuItem with builder (divider)
                // const SizedBox.shrink(),

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
