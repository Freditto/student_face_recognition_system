import 'dart:convert';
import 'package:flutter/material.dart';

class StudentDetailsPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String registration;
  final String gender;
  final String program;
  final String classLevel;
  final String ntaLevel;
  final bool isEligible;
  final String pic;

  const StudentDetailsPage({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.registration,
    required this.gender,
    required this.program,
    required this.classLevel,
    required this.ntaLevel,
    required this.isEligible,
    required this.pic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pic.isNotEmpty)
              Image.memory(
                base64Decode(pic),
                width: 300, // Adjust width as needed
                height: 300, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            Text('Name: $firstName $lastName', style: TextStyle(fontSize: 14),),
            Text('Registration: $registration',style: TextStyle(fontSize: 14),),
            Text('Gender: $gender', style: TextStyle(fontSize: 14),),
            Text('Program: $program', style: TextStyle(fontSize: 14),),
            Text('Class: $classLevel', style: TextStyle(fontSize: 14),),
            Text('NTA Level: $ntaLevel', style: TextStyle(fontSize: 14),),
            Text('Eligibility: ${isEligible ? 'Eligible' : 'Not Eligible'}', style: TextStyle(fontSize: 14),),
            // Decode base64 string and display image if pic is not null
          ],
        ),
      ),
    );
  }
}
