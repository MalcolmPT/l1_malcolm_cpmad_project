import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/activity.dart';
import 'package:l1_malcolm_cpmad_project/features/feedback.dart';
import 'package:l1_malcolm_cpmad_project/features/homepage.dart';
import 'package:l1_malcolm_cpmad_project/features/activity.dart';
import 'package:l1_malcolm_cpmad_project/features/aboutus.dart';
import 'package:l1_malcolm_cpmad_project/screens/profile.dart';

import 'features/signup.dart';
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
      home: const ProfilePage(), //Temporary testing homepage UI
    );
  }
}