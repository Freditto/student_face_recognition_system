import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:facial_recognition_app/api.dart';
import 'package:facial_recognition_app/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_model.dart';
import '../providers/student_provider.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _regNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _ntaLevelController = TextEditingController();

  final ValueNotifier<bool> _isEligible = ValueNotifier<bool>(false);

  File? _image;
  String? _imagePath;

  bool imageAvailable = false;
  late Uint8List imageFile;

  Future<void> _getImage() async {
    try {
      final pickedFile =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile.files.first.bytes!;
          imageAvailable = true;
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  _add_record_API() async {
    print('Bra_______bra');

    print(_isEligible.value);

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromBytes(
        imageFile,

        filename: 'image.jpg', // Use a default filename here
        // contentType:  MediaType("image", "jpg"), //add this
      ),
      "firstname": _firstnameController.text,
      "lastname": _lastnameController.text,
      "registration": _regNumberController.text,
      "gender": _genderController.text,
      "program": _programController.text,
      "class": _classController.text,
      "nta_level": _ntaLevelController.text,
      "is_eligible": _isEligible.value.toString(),
    });

    print(formData);

    var res =
        await CallApi().authenticatedUploadRequest(formData, 'add_record');
    if (res == null) {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
    } else {
      // var body = json.decode(res!.body);
      // print(body);

      var body = res.data; // Access response data instead of body
      print(body);

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
          content: Text('File Uploaded Successfully'),
        ));

        Navigator.pop(this.context);

        setState(() {});
      } else if (res.statusCode == 400) {
        print('hhh');
        // setState(() {
        //   _isLoading = false;
        //   _not_found = true;
        // });
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.0),
                imageAvailable
                    ? Column(
                        children: [
                          Image.memory(
                            imageFile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          if (_imagePath != null) // Display the file path
                            Text('File Path: $_imagePath'),
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 16.0),
                // ElevatedButton(
                //   onPressed: () {
                //     _getImage(ImageSource.camera);
                //   },
                //   child: Text('Take Picture'),
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.circular(20.0), // Rounded corners
                //     ),
                //     padding:
                //         EdgeInsets.symmetric(vertical: 16.0), // Increase height
                //     minimumSize: Size(double.infinity, 0), // Take full width
                //   ),
                // ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _getImage();
                  },
                  child: Text('Choose from Gallery'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0), // Increase height
                    minimumSize: Size(double.infinity, 0), // Take full width
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _firstnameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _lastnameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _regNumberController,
                  decoration: InputDecoration(
                    labelText: 'Registration Number',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _programController,
                  decoration: InputDecoration(
                    labelText: 'Program',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _classController,
                  decoration: InputDecoration(
                    labelText: 'Class',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _ntaLevelController,
                  decoration: InputDecoration(
                    labelText: 'NTA Level',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ValueListenableBuilder<bool>(
                  valueListenable: _isEligible,
                  builder: (context, value, child) {
                    return SwitchListTile(
                      title: Text('Is Eligible'),
                      value: value,
                      onChanged: (bool newValue) {
                        _isEligible.value = newValue;
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // if (_firstnameController.text.isNotEmpty &&
                    //     _regNumberController.text.isNotEmpty) {
                    //   Uint8List? pictureBytes;
                    //   if (_image != null) {
                    //     final bytes = await _image!.readAsBytes();
                    //     pictureBytes = bytes;
                    // }
                    // final newStudent = Student(
                    //   regNumber: _regNumberController.text,
                    //   first_name: _firstnameController.text,
                    //   last_name: _lastnameController.text,
                    //   gender: _genderController.text,
                    //   program: _programController.text,
                    //   studentClass: _classController.text,
                    //   ntaLevel: _ntaLevelController.text,
                    //   isEligible: _isEligible.value,
                    //   picture: pictureBytes,
                    // );
                    // Provider.of<StudentProvider>(context, listen: false)
                    //     .addStudent(newStudent);
                    _add_record_API();
                   
                    // }
                  },
                  child: Text('Add Student'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0), // Increase height
                    minimumSize: Size(double.infinity, 0), // Take full width
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
