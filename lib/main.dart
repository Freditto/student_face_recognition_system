import 'package:facial_recognition_app/admin_web/admin_login_screen.dart';
import 'package:facial_recognition_app/splash/splash_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

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
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        // Add more providers as needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facial Recognition App',
        home: isMobile ? MySplashViews() : AdminLoginScreen(),
      ),
    );
  }
}
