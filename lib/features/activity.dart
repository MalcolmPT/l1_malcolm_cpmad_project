import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:l1_malcolm_cpmad_project/features/profile.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';
import 'drawer.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String username = '';
  String imageUrl = ''; 
  String backgroundUrl = ''; 
  bool isStarted = false;
  int todaySteps = 0; // Variable to store today's steps
  double caloriesBurnt = 0.0; // Variable to store calories burnt
  double distanceKm = 0.0; // Variable to store distance in Km
  String activityTime = "0h0min"; // Placeholder for time spent
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchTodayData();  // Fetch today's data on initialization
  }
  Future<void> _fetchUserData() async {
    final userData = await _authService.fetchUserData();

    setState(() {
      username = userData['username'] ?? 'User';
      imageUrl = userData['imageUrl'] ?? '';
      backgroundUrl = userData['backgroundUrl'] ?? '';
    });
  }

  void _toggleButton() {
    setState(() {
      isStarted = !isStarted;
    });
  }

  Future<void> _fetchTodayData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('TodaysSteps')
            .where('uid', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            todaySteps = querySnapshot.docs.first['steps'] ?? 0;
            _calculateMetrics();
          });
        }
      }
    } catch (e) {
      print('Error fetching today\'s data: $e');
    }
  }

  void _calculateMetrics() {
    const double caloriesPerStep = 0.04; // Calories burnt per step
    const double kmPerStep = 0.0008; // Distance in km per step

    setState(() {
      caloriesBurnt = todaySteps * caloriesPerStep;
      distanceKm = todaySteps * kmPerStep;
      activityTime = _calculateTime(todaySteps); // Replace with actual logic if needed
    });
  }

  String _calculateTime(int steps) {
    // Placeholder logic: assuming average walking speed is 5 km/h
    const double averageSpeedKmH = 5.0;
    double timeHours = distanceKm / averageSpeedKmH;
    int hours = timeHours.floor();
    int minutes = ((timeHours - hours) * 60).round();
    return "${hours}h${minutes}min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Activity.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                        );
                      }
                    ),
                    const Text(
                      "Activity",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                Stack(
                  children: [
                    Image.asset(
                      "images/TodaysStep.png",
                      height: 160,
                      width: 160,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(46, 85, 0, 0),
                      child: Text(
                        "$todaySteps",  // Display the fetched today's steps
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ), 
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Today's Steps",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 15),
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Optional: set border radius
                  ),
                  child: Container(
                    width: 350,
                    height: 160,
                    child: Column(
                      children: [
                        const SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("images/Location.png", height: 40, width:40) ,
                            Image.asset("images/CaloriesBurnt.png", height: 40, width:40),
                            Image.asset("images/RunTiming.png", height: 40, width:40)
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: const EdgeInsets.only(left: 15), child: Text(distanceKm.toStringAsFixed(2))),   
                            Padding(padding: const EdgeInsets.only(left: 22), child: Text(caloriesBurnt.toStringAsFixed(2))),   
                            Padding(padding: const EdgeInsets.only(left: 10), child: Text(activityTime)),  
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Padding(padding: EdgeInsets.only(left: 5), child: Text("Km")),   
                            Padding(padding: EdgeInsets.only(left: 10), child: Text("Kcal")),   
                            Padding(padding: EdgeInsets.only(left: 10), child: Text("Time")), 
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleButton,
                  child: Text(isStarted ? 'Stop' : 'Start', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: const Color(0xFFFFA500),
                    padding: const EdgeInsets.fromLTRB(152, 2, 152, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
