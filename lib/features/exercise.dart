import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ,
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
                  Text("Exercise Library", style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  IconButton(onPressed:(){
                    //  Profile Pic Placeholder
                  }, 
                  icon: Icon(Icons.circle),
                  iconSize: 50,),
                  
                ],
              ),
              Padding(
                padding: EdgeInsets.all(14),
                              child: TextField(
                  decoration: InputDecoration(
                        hintText: 'Search',
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
              )
              
                          
            ],
          ),
        ),
    );
  }
}