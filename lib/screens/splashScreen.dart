import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/createProfile.dart';
import 'package:testproj/screens/homeScreen.dart';
import 'package:testproj/screens/signin.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool? check = sharedPreferences.getBool("profile");
        if (check != null && check == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const homeScreen()),
          );
        } else if (check == false || check == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const createProfile()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const signIn()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:
          backgroundColor, // Set your desired background color here
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0), // Set the desired left padding value
            child: Text(
              'Make your way for',
              style: TextStyle(
                wordSpacing: 0,
                fontSize: 65,
                color: lightGrey, // Set your desired text color here
                fontWeight: FontWeight.bold, // Set the text to bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0), // Set the desired left and top padding values
            child: Text(
              'Snapzy',
              style: TextStyle(
                fontSize: 65,
                color: companyColor, // Set your desired text color here
                fontWeight: FontWeight.bold, // Set the text to bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0), // Set the desired left and top padding values
            child: Text(
              'A True Social Media',
              style: TextStyle(
                fontSize: 20,
                color: darkGrey, // Set your desired text color here
                fontWeight: FontWeight.bold, // Set the text to bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0), // Set the desired left and top padding values
            child: Text(
              'From JK LTD.',
              style: TextStyle(
                fontSize: 14,
                color: lightGrey, // Set your desired text color here
                fontWeight: FontWeight.bold, // Set the text to bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}
