import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:l1_malcolm_cpmad_project/features/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/signup.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Other widgets go here
           Center(
            child: Padding(
              padding: EdgeInsets.all(30),
                          child: Column(
                children: [
                  SizedBox( height: 30,),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:15),
                        child: Text("Login", style: TextStyle(fontSize: 30),))
                    ],
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
                      hintText: 'Password',
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
                  
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 140),
                                                      child: ElevatedButton(
                              onPressed: () {

                              },
                              child: Text('Done', style: TextStyle(fontSize: 18  ),),
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                backgroundColor: Color.fromARGB(255, 0, 183, 165),
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.0),   // Round only the top left corner
                                    topRight: Radius.circular(0),  // Round only the top right corner
                                    bottomLeft: Radius.circular(0),   // No rounding on the bottom left corner
                                    bottomRight: Radius.circular(12.0),  // No rounding on the bottom right corner
                                  ),

                                )
                              ),
                            ),
                          ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                                      child: RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 15)
                        ), 
                        TextSpan(
                          text: " Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to Login Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                        )
                      ]
                    )),
                  )
                        ],
                      )
                    ],
                  )
                  
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
