import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/addPost.dart';
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
    addPostPage(),
    userProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: lightGrey,
        unselectedItemColor: const Color.fromRGBO(1, 1, 1, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        iconSize: 25,
        onTap: _navigateBottom,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust_outlined),
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Addpost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
