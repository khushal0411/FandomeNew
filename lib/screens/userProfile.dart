import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testproj/screens/addPost.dart';
import 'package:testproj/screens/editProfile.dart';

import '../constant/color.dart';
import 'package:firebase_database/firebase_database.dart';

class userProfilePage extends StatefulWidget {
  const userProfilePage({super.key});

  @override
  State<userProfilePage> createState() => _userProfilePageState();
}

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
// DatabaseReference databaseReference=FirebaseDatabase.instance.ref();
// databaseReference.child("Users").child(user!.uid.toString()).once().then((value){
// final data= value.snapshot;
// Object? values = data.value;
// Map<dynamic, dynamic>? personMap = values as Map?;
// print(personMap!.keys.first.toString());
//  String p=user.uid.toString()+"/"+personMap!.keys.first.toString();
// databaseReference.child('Users/$p').update(updatedData).then((value) {
//     print('Data updated successfully $p');
//   }).catchError((error) {
//     print('Failed to update data: $error');
//   });

// });
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

class _userProfilePageState extends State<userProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Row(
          children: [
            Text(
              "angilinamario24",
              style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.verified,
                color: Colors.blue,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const editProfile()));
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const addPostPage()));
            },
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Center(
                            child: SizedBox(
                          height: 1,
                        )),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35, left: 20, right: 10, bottom: 10),
                              child: Icon(
                                Icons.settings_outlined,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35, left: 0, right: 10, bottom: 10),
                              child: Text(
                                "Settings",
                                style:
                                    TextStyle(color: textColor, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.menu,
              color: textColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 5, top: 10),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: Image.asset("assets/images/story.png"),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 5, bottom: 0, top: 0),
                          child: Text(
                            "Angilina Mario",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, bottom: 0, top: 0),
                            child: Icon(
                              Icons.verified,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, right: 10, bottom: 0, top: 0),
                      child: Text(
                        "Product Designing",
                        style: TextStyle(
                          fontSize: 13,
                          color: darkGrey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 5.0, bottom: 0, top: 0),
                            child: Icon(
                              Icons.pin_drop_outlined,
                              color: darkGrey,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 10, bottom: 0, top: 0),
                          child: Text(
                            "Sheffield, West London",
                            style: TextStyle(
                              fontSize: 13,
                              color: darkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: Text(
                "Adventure seeker ✨ | Passionate about new ventures 🌟 | Spreading positivity 📸 | Capturing the beauty of the world 🌍Capturing the beauty of the world 🌍",
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
            const Row(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 0.0, bottom: 5.0),
                    child: Icon(
                      Icons.link_rounded,
                      color: Color.fromARGB(255, 38, 102, 154),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 10.0, bottom: 5.0),
                  child: Text(
                    "https://dribbble.com/search/profile",
                    style: TextStyle(
                        color: Color.fromARGB(255, 38, 102, 154),
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Your posts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            GridView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: lightGrey,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
