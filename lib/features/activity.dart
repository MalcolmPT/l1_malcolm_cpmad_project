import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool isStarted = false;

  void _toggleButton() {
    setState(() {
      isStarted = !isStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Text(
                      "Activity",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                Stack(
                  children: [
                    Image.asset(
                      "images/TodaysStep.png",
                      height: 160,
                      width: 160,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(46, 85, 0, 0),
                      child: Text(
                        "5000",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ), // Placeholder
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("images/Location.png"),
                            Image.asset("images/CaloriesBurnt.png"),
                            Image.asset("images/RunTiming.png")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleButton,
                  child: Text(isStarted ? 'Stop' : 'Start', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                   style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Color(0xFFFFA500),
                              padding: EdgeInsets.fromLTRB(152, 2, 152, 2),
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0
                                    ),

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

