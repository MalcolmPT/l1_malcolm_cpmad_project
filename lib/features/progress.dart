import 'package:flutter/material.dart';
import 'package:l1_malcolm_cpmad_project/features/progress2.dart';

class Progress1 extends StatelessWidget {
  const Progress1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Progress.png'),
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
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      iconSize: 50,
                    ),
                    const Text(
                      "Progress",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        // Profile Pic Placeholder
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Colors.black,
                      ),
                      iconSize: 50,
                    ),
                  ],
                ),

                Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Optional: set border radius
              ),   
                  child: Container(
                  width: 350,
                  height: 230,
                  decoration: BoxDecoration(//
                    color: const Color(0xFFFFFFFF), // Set the background color to #1A2947
                    borderRadius: BorderRadius.circular(15.0), // Set the border radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5,0,15,0),
                                  child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                                  child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Text("Last week", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w400 ),),
                              Stack(
                                children: [
                                 
                                ],
                              ),
                              
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
                      Padding(
                        padding: EdgeInsets.all(16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            
                            CustomIconText(onPressed: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Progress2()),
                            );
                            }, text: 'Mon'),

                            CustomIconText(onPressed: (){

                            }, text: 'Tues'),

                            CustomIconText(onPressed: (){

                            }, text: 'Wed'),

                            CustomIconText(onPressed: (){

                            }, text: 'Thu'),

                            CustomIconText(onPressed: (){

                            }, text: 'Fri'),

                            CustomIconText(onPressed: (){

                            }, text: 'Sat'),

                            CustomIconText(onPressed: (){

                            }, text: 'Sun'),
                          ],
                        ),
                      )
              ]
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomIconText({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.circle,
            color: Color.fromARGB(255, 255, 165, 0),
          ),
          iconSize: 18,
        ),
        Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
      ],
    );
  }
}