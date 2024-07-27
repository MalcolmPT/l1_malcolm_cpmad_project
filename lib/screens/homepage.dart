import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F3),
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
            Container(
              width: 350,
              height: 200,
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
                          children: [
                            Image.asset('images/shoe.png', height: 30, width: 30,)
                          ],
                        )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}