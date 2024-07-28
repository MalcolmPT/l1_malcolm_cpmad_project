import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAE9DD),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          iconSize: 50,
          onPressed: () {
            //drawer
          },
        ),
        title: Text(
          'Feedback',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 6.0,
        actions: [
          IconButton(
            icon: Icon(Icons.circle),
            color: Colors.black,
            iconSize: 46,
            onPressed: () {
              //Profile
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  //controller: ,
                  decoration: InputDecoration(
                    hintText: 'Subject',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    contentPadding: EdgeInsets.only(left: 30.0),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  //controller: ,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    contentPadding: EdgeInsets.only(left: 30.0),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset("images/Feedback.png"),
                SizedBox(height: 30),

                ElevatedButton(onPressed:(){
                                
                            }, 
                            child: Text("Exercises", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: Color(0xFF1A2947)
,
                              padding: EdgeInsets.fromLTRB(150, 10, 150, 10),
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(36.0
                                    ),

                                  )
                            )
                            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


