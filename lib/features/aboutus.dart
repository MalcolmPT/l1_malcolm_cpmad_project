import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l1_malcolm_cpmad_project/features/exercise.dart';
import 'package:l1_malcolm_cpmad_project/features/profile.dart'; // Import ProfilePage
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'drawer.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String imageUrl = ''; 
  String username = ''; 
  String backgroundUrl = ''; 

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final authService = FirebaseAuthService();
    final userData = await authService.fetchUserData();

    setState(() {
      username = userData['username'] ?? 'User';
      imageUrl = userData['imageUrl'] ?? '';
      backgroundUrl = userData['backgroundUrl'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      drawer: AppDrawer(),
      body: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                    iconSize: 50,
                  ),
                  Hero(
                    tag: 'profile-image-hero', // A unique tag for the Hero animation
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 25, // Adjust size as needed
                        backgroundColor: Colors.grey, // Placeholder color
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null, // Use the image URL if available
                        child: imageUrl.isEmpty
                            ? const Icon(Icons.person, size: 50, color: Colors.white)
                            : null, // Placeholder icon if no image URL
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                "images/Aboutus.png",
                height: 250,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    "About us",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    "We are a non-profit company that aims to improve the quality of life for Singaporeans",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    "Our Objective",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    "Our app aims to helps all walks of life get into an active and healthy lifestyle. Many of us often wish to make this leap of faith but often find it hard to take the first step. With this app, we provide users a multitude of ways to get started in leading a healthier lifestyle",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExercisePage()),
                  );
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 6,
                    padding: const EdgeInsets.fromLTRB(140, 10, 140, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
