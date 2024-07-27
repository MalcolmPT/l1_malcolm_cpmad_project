import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Activity.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Container(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      iconSize: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        // Profile Pic Placeholder
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      iconSize: 50,
                    ),
                  ],
                ),

                Image.asset("images/TodaysStep.png")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Background Image Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Activity(),
    );
  }
}
