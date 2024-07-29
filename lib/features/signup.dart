import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../services/firebaseauth_service.dart';
import '../firebase_options.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Expanded(
                          child: Form(
          key: _formKey,
          child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 30),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor:
                          Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.0)),
                      contentPadding: EdgeInsets.only(left: 30.0)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor:
                          Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.0)),
                      contentPadding: EdgeInsets.only(left: 30.0)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor:
                          Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.0)),
                      contentPadding: EdgeInsets.only(left: 30.0)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor:
                          Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(36.0)),
                      contentPadding: EdgeInsets.only(left: 30.0)),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_passwordController.text.trim() ==
                        _confirmPasswordController.text.trim()) {
                      var newuser = await FirebaseAuthService().signUp(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          username: _usernameController.text.trim());
                      if (newuser != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Color.fromARGB(255, 0, 183, 165),
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0))),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                    text: " Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 183, 165),
                        fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                      },
                  )
                ]))
              ],
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
