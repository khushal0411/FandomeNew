import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

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
              'FanDome',
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
