import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/profile.dart';
import 'package:l1_malcolm_cpmad_project/features/progress.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'package:l1_malcolm_cpmad_project/features/barchart.dart';  
import 'exercise.dart';
import 'activity.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  String imageUrl = ''; 
  String backgroundUrl = ''; 
  int todaySteps = 0; // Variable to store today's steps
  Map<String, int> stepsData = {};
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchStepsData();  // Fetch the steps data for the chart
  }

  Future<void> _fetchUserData() async {
    final userData = await _authService.fetchUserData();

    setState(() {
      username = userData['username'] ?? 'User';
      imageUrl = userData['imageUrl'] ?? '';
      backgroundUrl = userData['backgroundUrl'] ?? '';
    });
  }

  Future<void> _fetchStepsData() async {
    final data = await _authService.fetchActivityData();
    setState(() {
      stepsData = data;
    });

    final todaySteps = await _authService.fetchTodaySteps();
    setState(() {
      this.todaySteps = todaySteps;
    });
  }

  Future<void> _uploadBackgroundImage() async {
    String? downloadUrl = await _authService.uploadBackgroundImage();

    if (downloadUrl != null) {
      setState(() {
        backgroundUrl = downloadUrl;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Background image updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update background image')),
      );
    }
  }

  Future<void> _removeBackgroundImage() async {
    bool success = await _authService.removeBackgroundImage();

    if (success) {
      setState(() {
        backgroundUrl = ''; 
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Background image removed successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove background image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAE9DD),
      drawer: AppDrawer(),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: 700,
            decoration: backgroundUrl.isNotEmpty
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(backgroundUrl),
                      fit: BoxFit.cover, 
                    ),
                  )
                : null,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: _uploadBackgroundImage,
                          icon: const Icon(Icons.image),
                          iconSize: 30,
                        ),
                        if (backgroundUrl.isNotEmpty) 
                          IconButton(
                            onPressed: _removeBackgroundImage,
                            icon: const Icon(Icons.delete),
                            iconSize: 30,
                          ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage()), // Navigate to profile page
                            );
                          },
                          child: Hero(
                            tag:
                                'profile-image-hero', // Unique tag for the hero animation
                            child: CircleAvatar(
                              radius: 25, // Adjust size as needed
                              backgroundColor: Colors.grey, // Placeholder color
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : null, // Use the image URL if available
                              child: imageUrl.isEmpty
                                  ? const Icon(Icons.person,
                                      size: 50, color: Colors.white)
                                  : null, // Placeholder icon if no image URL
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 175),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Hello, ",
                          style: TextStyle(color: Colors.black, fontSize: 23),
                        ),
                        TextSpan(
                          text: "$username!",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 33,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Activity()),
                    );
                  },
                                  child: Card(
                    color: Colors.transparent,
                    elevation: 20.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: 350,
                      height: 210,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2947).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 17,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Activity",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/shoe.png',
                                  height: 70,
                                  width: 70,
                                ),
                                Text(
                                  "$todaySteps", // Use today's steps from the fetched data
                                  style: const TextStyle(
                                      fontSize: 52,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Text("Steps Walked",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.white))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Progress1()),
                    );
                  },
                  child: stepsData.isNotEmpty
                      ? CustomBarChart(
                          stepsData: stepsData,
                          barWidth: 25,
                          barColor: Colors.orange,
                          containerColor: const Color(0xFFFCC999).withOpacity(0.6),
                          size: const Size(350, 210),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExercisePage()),
                        );
                      },
                      child: const Text(
                        "Exercises",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 4,
                          backgroundColor: const Color(0xFFFFA500),
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ))),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
