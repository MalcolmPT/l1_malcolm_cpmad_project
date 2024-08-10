import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/barchart.dart';
import 'package:l1_malcolm_cpmad_project/features/drawer.dart';
import 'package:l1_malcolm_cpmad_project/features/profile.dart';
import 'package:l1_malcolm_cpmad_project/features/progress2.dart';
import 'package:l1_malcolm_cpmad_project/services/firebaseauth_service.dart';

class Progress1 extends StatefulWidget {
  const Progress1({super.key});

  @override
  _Progress1State createState() => _Progress1State();
}

class _Progress1State extends State<Progress1> {
  late Map<String, int> stepsData;
  String username = '';
  String imageUrl = ''; 
  String backgroundUrl = ''; 
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchUserData();
  }
  Future<void> _fetchUserData() async {
    final userData = await _authService.fetchUserData();

    setState(() {
      username = userData['username'] ?? 'User';
      imageUrl = userData['imageUrl'] ?? '';
      backgroundUrl = userData['backgroundUrl'] ?? '';
    });
  }
  Future<void> _fetchData() async {
    final data = await _authService.fetchActivityData();
    setState(() {
      stepsData = data;
      isLoading = false;
    });
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
                image: AssetImage('images/Progress.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
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
                                    color: Colors.black,
                                  ),
                                  iconSize: 50,
                                );
                              },
                            ),
                            const Text(
                              "Progress",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
                        const SizedBox(height: 25),
                        CustomBarChart(
                          stepsData: stepsData,
                          barWidth: 25,
                          barColor: Colors.orange, 
                          containerColor: Colors.white,
                          size: Size(350, 220),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Monday')),
                                  );
                                },
                                text: 'Mon',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Tuesday')),
                                  );
                                },
                                text: 'Tues',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Wednesday')),
                                  );
                                },
                                text: 'Wed',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Thursday')),
                                  );
                                },
                                text: 'Thur',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Friday')),
                                  );
                                },
                                text: 'Fri',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Saturday')),
                                  );
                                },
                                text: 'Sat',
                              ),
                              CustomIconText(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Progress2(day: 'Sunday')),
                                  );
                                },
                                text: 'Sun',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class CustomIconText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomIconText({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.circle,
            color: Color.fromARGB(255, 255, 165, 0),
          ),
          iconSize: 18,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
