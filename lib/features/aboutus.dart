import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/exercise.dart';


class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      // drawer: Drawer,
      body: Container(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              
              Image.asset("images/Aboutus.png", height: 250,),
              
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "About us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
                ),
                SizedBox(height: 10,),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "We are a non-profit company that aims to improve the quality of life for Singaporeans",
                  style: TextStyle( fontSize: 16),
                ),
              ),
                ),

              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "Our Objective",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
                ),
                SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  "Our app aims to helps all walks of life get into an active an healthy lifestyle. Many of us often wish to make this leap of faith but often find it hard to take the first step. With this app, we provide user a multitude of ways to get started in leading a healthier lifestyle",
                  style: TextStyle( fontSize: 16),
                ),
              ),
                ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed:(){
                                Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ExercisePage()),
                            );
                            }, 
                            child: Text("GetStarted", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              elevation: 6,
                              padding: EdgeInsets.fromLTRB(140, 10, 140, 10),
                                  
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