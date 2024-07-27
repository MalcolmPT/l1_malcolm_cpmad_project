import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Other widgets go here
          const Center(
            child: Text(
              'Welcome to the Homepage',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
