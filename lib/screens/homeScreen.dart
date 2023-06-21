import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

Future<void> pushData() async {
  Map<String, dynamic> updatedData = {
    "name": "Joy Goyal",
    "age": "92",
    "isVerified": true,
    "link": "test",
    "bio":
        "John Doe is a highly experienced Senior Designer with a passion for creating visually stunning and impactful designs. With over 10 years of professional experience in the design industry, John has a proven track record of delivering exceptional design solutions that meet client objectives. ",
    "profilePic": "data",
    "location": "Toronto, ON, CA",
    "designation": "Senior Designer",
    "dob": "22-06-2001"
  };
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = firebaseAuth.currentUser;
  // data updation
DatabaseReference databaseReference=FirebaseDatabase.instance.ref();
databaseReference.child("Users").child(user!.uid.toString()).once().then((value){
final data= value.snapshot;
Object? values = data.value;
Map<dynamic, dynamic>? personMap = values as Map?;
print(personMap!.keys.first.toString());
 String p=user.uid.toString()+"/"+personMap!.keys.first.toString();
// databaseReference.child('Users/$p').update(updatedData).then((value) {
//     print('Data updated successfully $p');
//   }).catchError((error) {
//     print('Failed to update data: $error');
//   });

databaseReference.child('Users/$p').once().then((value) async {
final data= value.snapshot;
Object? values = data.value;
Map<dynamic, dynamic>? profileData = values as Map?;
List l= profileData!.values.toList() ;
print(l.toString());
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
List<String> stringList=l.map((item) => item.toString()).toList();
print(stringList);
sharedPreferences.setStringList("k", stringList);

});

});
// .push().set({
//   "name":"Khushal Goyal",
//   "age":"22",
//   "isVerified":true,
//   "link":"test",
//   "bio":"John Doe is a highly experienced Senior Designer with a passion for creating visually stunning and impactful designs. With over 10 years of professional experience in the design industry, John has a proven track record of delivering exceptional design solutions that meet client objectives. ",
//   "profilePic":"data",
//   "location":"Toronto, ON, CA",
//   "designation":"Senior Designer",
//   "dob":"22-06-2001"
// });
}




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
    pushData();
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
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
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
