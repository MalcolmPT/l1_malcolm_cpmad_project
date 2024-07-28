import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/progress.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Profile.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                  iconSize: 50,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 145),
                  child: Text("Your Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),))
              ],
            ),
            // Add more content here
          ],
        ),
      ),
    );
  }
}


