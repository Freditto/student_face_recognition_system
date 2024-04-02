import 'package:facial_recognition_app/splash/splash_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/student_provider.dart';

void main() {
  // setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),

        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facial Recognition App',
        home: MySplashViews(),
      ),
    );
  }
}
