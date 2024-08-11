import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _authService = FirebaseAuth.instance;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password", style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xFFFAE9DD),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Enter your email and we'll send you a link to reset your password.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
            
            Image.asset("images/forgotPW.jpg"),

            ElevatedButton(
              onPressed:() async {
                await _authService.sendPasswordResetEmail(
                  email: _emailController.text.trim(),
                );
              },
              child: const Text("Send Reset", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2947),
                padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
