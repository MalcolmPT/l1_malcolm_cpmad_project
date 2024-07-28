import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/Profile.dart';
import 'package:l1_malcolm_cpmad_project/features/login.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                ),
                Text("Your Profile", style: TextStyle(fontSize: 16),),
                Spacer(),
                Text("About Me",  style: TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 30,
                ),
              ],
            ),
            Icon(
              Icons.circle,
              size: 140,
              color: Colors.black,
            ),
            SizedBox(height: 20,),
            TextField(
                    //controller: ,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      fillColor: Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36.0)
                      ),
                      contentPadding: EdgeInsets.only(left: 30.0)
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    //controller: ,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      fillColor: Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36.0)
                      ),
                      contentPadding: EdgeInsets.only(left: 30.0)
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    //controller: ,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      fillColor: Colors.white, // Set the background color to white
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(36.0)
                      ),
                      contentPadding: EdgeInsets.only(left: 30.0)
                    ),
                  ),

                  Expanded(child: Image.asset("images/EditProfile.png")),

                  ElevatedButton(onPressed:(){
                                //confirm
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

