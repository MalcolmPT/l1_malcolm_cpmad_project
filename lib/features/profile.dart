import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/editprofile.dart';
import 'package:l1_malcolm_cpmad_project/features/login.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String description = "Fetching description...";
  String username = "Fetching username...";
  String imageUrl = ""; 
  int totalDistance = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    calculateTotalDistance();
  }

  Future<void> fetchUserData() async {
    final authService = FirebaseAuthService();
    final userData = await authService.fetchUserData();

    setState(() {
      username = userData['username'] ?? 'User';
      imageUrl = userData['imageUrl'] ?? '';
      description = userData['description'] ?? '';
    });
  }

  Future<void> calculateTotalDistance() async {
    final authService = FirebaseAuthService();
    final weeklySteps = await authService.fetchActivityData(); // Fetch weekly step data
    
    // Assuming 1 step = 0.000762 kilometers
    const double stepToKmFactor = 0.000762;
    
    int totalSteps = 0;
    weeklySteps.forEach((day, steps) {
      totalSteps += steps;
    });

    setState(() {
      totalDistance = (totalSteps * stepToKmFactor).round(); // Convert to kilometers and round off
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Profile.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(Icons.menu),
                        iconSize: 50,
                        color: Colors.white,
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 145),
                    child: Text(
                      "Your Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Hero(
                tag: "profile-image-hero",
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : null, 
                  child: imageUrl.isEmpty
                      ? Icon(Icons.circle, size: 70, color: Colors.grey)
                      : null,
                ),
              ),
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                    ),
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Total Distance",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Image.asset(
                                "images/TotalDistance.png",
                                height: 120,
                                width: 120,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 48, top: 65),
                              child: Text(
                                "$totalDistance km", // Display the calculated distance
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "About Me",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Color(0xFF1A2947),
                  padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuthService().signOut();  //unauthenticate the user
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()), 
                    (Route<dynamic> route) => false,  //remove all existing pages 
                  );
                }, 
                child: Text(
                  "Log out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Color(0xFFFFA500),
                  padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0),
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
