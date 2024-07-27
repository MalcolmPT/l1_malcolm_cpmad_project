import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/signup.png'),
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
