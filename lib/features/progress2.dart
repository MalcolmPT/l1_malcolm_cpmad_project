import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Progress2 extends StatelessWidget {
  final String day;
  const Progress2({Key? key, required this.day}) : super(key: key);

  Future<Map<String, dynamic>> _fetchDayData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Activity')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return doc.data() as Map<String, dynamic>;
      }
    }

    return {}; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchDayData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available for $day.'));
          }

          var dayData = snapshot.data![day] ?? 0;
          var steps = dayData;
          var distance = (steps * 0.0008).toStringAsFixed(2); 
          var calories = (steps * 0.04).toStringAsFixed(2); 
          var time = (steps * 0.02).toStringAsFixed(2);

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Progress2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        iconSize: 50,
                      ),
                      const SizedBox(height: 30,),
                      Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text(
                          day,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Card(
                    color: Color.fromARGB(18, 255, 255, 255),
                    child: Container(
                      width: 350,
                      height: 260,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$steps", 
                                    style: TextStyle(color: Colors.grey[50], fontSize: 40, fontWeight: FontWeight.w500),
                                  ),
                                  Text("Steps", style: TextStyle(color: Colors.grey[50], fontSize: 20, fontWeight: FontWeight.w500))
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset("images/Location.png", height: 40, width: 40),
                                  SizedBox(height: 5,),
                                  Text("$distance km", style: TextStyle(color: Colors.white, fontSize: 15),),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset("images/CaloriesBurnt.png", height: 40, width: 40),
                                  SizedBox(height: 5,),
                                  Text("$calories kcal", style: TextStyle(color: Colors.white, fontSize: 15),),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset("images/RunTimingProgress2.png", height: 40, width: 40),
                                  SizedBox(height: 5,),
                                  Text("$time mins", style: TextStyle(color: Colors.white, fontSize: 15),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
