import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facial_recognition_app/api.dart';
import 'package:facial_recognition_app/screens/student_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'scan_screen.dart';
import '../admin_web/admin_login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   File? _image;

  String? _imagePath;

  Future<void> _getImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _imagePath = pickedFile.path;
        });

        _showImageDialog(context); // Pass the context to showImageDialog

        await _verify_image_API();

        //  Navigator.pop(context); // Dismiss the dialog
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              SizedBox(height: 16.0), // Adjust spacing as needed
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 16.0), // Adjust spacing as needed
              Center(
                child: Text('Loading...'),
              ),
              SizedBox(height: 16.0), // Adjust spacing as needed
              ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  _verify_image_API() async {
    if (_imagePath != null) {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          _imagePath!,
          filename: basename(_imagePath!),
        ),
      });

      var res =
          await CallApi().authenticatedUploadRequest(formData, 'verify_image');
      if (res == null) {
        // Handle network error
      } else {
        var body = res.data;
        print(res.requestOptions.uri); // Print the request URL
        print(res.data); // Print the response data

        if (body != null && res.statusCode == 200) {
          Navigator.push(
            this.context,
            MaterialPageRoute(
              builder: (context) => StudentDetailsPage(
                firstName: body['first_name'] ?? '',
                lastName: body['last_name'] ?? '',
                registration: body['registration'] ?? '',
                gender: body['gender'] ?? '',
                program: body['program'] ?? '',
                classLevel: body['class'] ?? '',
                ntaLevel: body['nta_level'] ?? '',
                isEligible: body['is_eligible'] ?? false,
                pic: body['pic'] ?? '',
              ),
            ),
          );
          
        } else {
          // Show dialog box indicating image verification failed
          showDialog(
            context: this.context,
            builder: (context) => AlertDialog(
              title: Text('Image Verification Failed'),
              content: Text('The provided image could not be verified.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } else {
      // Show dialog if _imagePath is null
      showDialog(
        context: this.context,
        builder: (context) => AlertDialog(
          title: Text('No Image Selected'),
          content: Text('Please select an image before verifying.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Facial Recognition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
              width: double.infinity,
              height: 70.0, // Set the height of the button
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                   _getImage(context, ImageSource.camera);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ScanScreen()),
                  // );
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Scan Student',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
