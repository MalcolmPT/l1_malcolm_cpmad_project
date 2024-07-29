import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/firebase_options.dart';

import 'features/signup.dart';
import 'features/activity.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform

  
  );
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
      home: const SignUpPage(), //Temporary testing homepage UI
    );
  }
}