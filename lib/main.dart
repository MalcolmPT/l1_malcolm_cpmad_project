import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/activity.dart';
import 'package:l1_malcolm_cpmad_project/screens/homepage.dart';
import 'screens/signup.dart';
import 'features/activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(), //Temporary testing homepage UI
    );
  }
}