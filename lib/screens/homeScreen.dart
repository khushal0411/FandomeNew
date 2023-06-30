import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/chat.dart';
import 'package:testproj/screens/explore.dart';
import 'package:testproj/screens/home.dart';
import 'package:testproj/screens/story.dart';
import 'package:testproj/screens/userProfile.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int _selectedIndex = 0;

  void _navigateBottom(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Different pages to navigate
  final List<Widget> _children = [
    homePage(),
    explorePage(),
    storyPage(),
    chatPage(),
    userProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(1, 1, 1, 1),
        unselectedItemColor: const Color.fromRGBO(1, 1, 1, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(size: 25.0, fill: 1),
        currentIndex: _selectedIndex,
        iconSize: 25,
        onTap: _navigateBottom,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(Icons.home_filled)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Icons.explore)
                : Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.circle)
                : Icon(Icons.circle_outlined),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Icon(Icons.chat_bubble)
                : Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Icon(Icons.account_circle)
                : Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
