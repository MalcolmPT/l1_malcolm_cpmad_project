import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login.png'),
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
                        child: Text("Sign Up", style: TextStyle(fontSize: 30),))
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
                      hintText: 'Email',
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
                  SizedBox(height: 10,),
                  TextField(
                    //controller: ,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Done', style: TextStyle(fontSize: 18  ),),
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Color.fromARGB(255, 0, 183, 165),
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0)
                      )
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 15)
                      ), 
                      TextSpan(
                        text: " Login",
                        style: TextStyle(color: Color.fromARGB(255, 0, 183, 165), fontSize: 15),
                        recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Login Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      )
                    ]
                  ))
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
