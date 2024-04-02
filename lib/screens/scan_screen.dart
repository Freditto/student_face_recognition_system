import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facial_recognition_app/api.dart';
import 'package:facial_recognition_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? _image;

  String? _imagePath;

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _imagePath = pickedFile.path;
        });

        _verify_image_API();
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  _verify_image_API() async {
    print('Bra_______bra');

    // print(file!.path);

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        _imagePath!,

        filename: basename(
          _imagePath!,
        ),
        // contentType:  MediaType("image", "jpg"), //add this
      ),
    });

    print(formData);

    var res =
        await CallApi().authenticatedUploadRequest(formData, 'verify_image');
    if (res == null) {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
    } else {
      var body = json.decode(res!.body);
      print(body);

      if (res.statusCode == 200) {
        showSnack(context, 'File Uploaded Successfully');

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
        title: Text('Scan Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.0),
                _image != null
                    ? Column(
                        children: [
                          Image.file(
                            _image!,
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
                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  child: Text('Take Picture'),
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
                ElevatedButton(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
