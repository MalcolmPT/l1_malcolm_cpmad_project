import 'package:flutter/material.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Define the action for the search button
              print('Search button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Define the action for the notifications button
              print('Notifications button pressed');
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Define the action for the more button
              print('More button pressed');
            },
          ),

        ],
      ),
    );
  }
}