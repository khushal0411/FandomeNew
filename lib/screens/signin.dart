import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/homeScreen.dart';
import 'package:testproj/screens/signupScreen.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});


  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
 
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(" "),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: [
                Text(
                  "Welcome ",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Text(
                  "Again",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: companyColor),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "Be Creative...",
              style: TextStyle(fontSize: 20, color: textColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
                filled: true,
                fillColor: trans,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: companyColor, width: 1.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter your password",
                filled: true,
                fillColor: trans,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: textColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: companyColor, width: 1.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(companyColor),
                  foregroundColor: MaterialStatePropertyAll(lightGrey),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const signUp()),);
              },
              child: Center(
                
                child: Text(
                  "Create new account",
                  style: TextStyle(
                    fontSize: 15,
                    color: textColor,
                  ),
                  
                ),
              ),
            ),
          ),
        ],
      ),
      
    );

  }
}
