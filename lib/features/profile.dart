import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/login.dart';
import 'package:l1_malcolm_cpmad_project/features/progress.dart';

import 'editProfile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer,
      body: Container(
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
            Icon(
              Icons.circle,
              size: 140,
              color: Colors.white,
            ),
            Text(
              "Malcolm Pye Thant",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Image.asset("images/TotalDistance.png", height:120 , width:120 ,),
                          ),
                          Padding(
                          padding: EdgeInsets.only(left: 48, top: 65),
                          child: Text("80000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "About Me",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "I love running and running and running and running and running and running and running and running and running and running and running and running and running and running and running and running ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed:(){
                                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfilePage()),
                            );
                            }, 
                            child: Text("Edit Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: Color(0xFF1A2947),
                              padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0
                                    ),

                                  )
                            )
                            ),
                            SizedBox(height: 5,),
                            ElevatedButton(onPressed:(){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                            }, 
                            child: Text("Log out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: Color(0xFFFFA500),
                              padding: EdgeInsets.fromLTRB(155, 10, 155, 10),
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0
                                    ),

                                  )
                            )
                            ),
          ],
        ),
      ),
    );
  }
}


