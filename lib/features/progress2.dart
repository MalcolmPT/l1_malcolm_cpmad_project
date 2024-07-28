import 'package:flutter/material.dart';

class Progress2 extends StatelessWidget {
  const Progress2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Progress2.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Container(
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
                      padding: EdgeInsets.only(left:100),
                                          child: const Text(
                        "Monday",       //This should dynamically change
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
                                Text("2000", style: TextStyle(color: Colors.grey[50], fontSize: 40, fontWeight: FontWeight.w500),),
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
                                Image.asset("images/Location.png", height: 40, width:40),
                                SizedBox(height: 5,),
                                Text("1.9", style: TextStyle(color: Colors.white, fontSize: 15),),
                                SizedBox(height: 5,),
                                Text("km", style: TextStyle(color: Colors.white, fontSize: 15))
                              ],
                            ),

                            Column(
                              children: [
                                Image.asset("images/CaloriesBurnt.png", height: 40, width:40),
                                SizedBox(height: 5,),
                                Text("1.9", style: TextStyle(color: Colors.white, fontSize: 15),),
                                SizedBox(height: 5,),
                                Text("km", style: TextStyle(color: Colors.white, fontSize: 15))
                              ],
                            ),

                            Column(
                              children: [
                                Image.asset("images/RunTimingProgress2.png", height: 40, width:40),
                                SizedBox(height: 5,),
                                Text("1.9", style: TextStyle(color: Colors.white, fontSize: 15),),
                                SizedBox(height: 5,),
                                Text("km", style: TextStyle(color: Colors.white, fontSize: 15))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
