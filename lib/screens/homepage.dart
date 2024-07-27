import 'package:flutter/material.dart';
import '../features/exercise.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAE9DD),
      // drawer: Drawer,
      body: Container(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed:(){
                    //  Scaffold.of(context).openDrawer();
                  }, 
                  icon: Icon(Icons.menu),
                  iconSize: 50,),
                  IconButton(onPressed:(){
                    //  Profile Pic Placeholder
                  }, 
                  icon: Icon(Icons.circle),
                  iconSize: 50,),
                  
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right:175),
                            child: RichText(text: TextSpan(
                  children: [
                    TextSpan(
                              text: "Hello, ",
                              style: TextStyle(color: Colors.black, fontSize: 23)
                            ),
                    TextSpan(
                              text: "Malcolm!",
                              style: TextStyle(color: Colors.black, fontSize: 33, fontWeight: FontWeight.bold)
                            ),
                  ]
                )),
              ),
              SizedBox(height: 20,),
              Card(
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Optional: set border radius
              ),  
                              child: Container(
                  width: 350,
                  height: 210,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2947), // Set the background color to #1A2947
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15,0,15,0),
                                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Activity", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                            Stack(
                              children: [
                                IconButton(onPressed:(){
                                  //  Goes to activity page
                                }, 
                                icon: Icon(Icons.circle,
                                color: Colors.white,),
                                iconSize: 50,),
                                Padding(  
                                  padding: EdgeInsets.fromLTRB(13, 13, 0, 0),
                                    child: Icon(
                                      Icons.arrow_outward,
                                      size: 40.0,
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/shoe.png', height: 70, width: 70,),
                                Text("5000" , style: TextStyle(fontSize: 52, color: Colors.white, fontWeight: FontWeight.bold),) //Placeholder for actual Dsitance
                              ],
                            ),
                            Text("Steps Walked", style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),


              Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Optional: set border radius
              ),   
                  child: Container(
                  width: 350,
                  height: 210,
                  decoration: BoxDecoration(//
                    color: const Color(0xFFFCC999), // Set the background color to #1A2947
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15,0,15,0),
                                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Progress", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                            Stack(
                              children: [
                                IconButton(onPressed:(){
                                  //  Goes to activity page
                                },  
                                icon: Icon(Icons.circle,
                                color: Colors.white,),
                                iconSize: 50,),
                                Padding(  
                                  padding: EdgeInsets.fromLTRB(13, 13, 0, 0),
                                    child: Icon(
                                      Icons.arrow_outward,
                                      size: 40.0,
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                            
                          ],
                        ),
                      
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 23,),
              SizedBox(
                width: 350,
                height: 50,
                              child: ElevatedButton(onPressed:(){
                                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExercisePage()),
                            );
                            }, 
                            child: Text("Exercises", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: Color(0xFFFFA500),
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0
                                    ),

                                  )
                            )
                            ),
              ),
                          
            ],
          ),
        ),
      
    );
  }
}