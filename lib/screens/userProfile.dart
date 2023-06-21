import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/screens/addPost.dart';
import 'package:testproj/screens/editProfile.dart';

import '../constant/color.dart';
import 'package:firebase_database/firebase_database.dart';

class userProfilePage extends StatefulWidget {
  const userProfilePage({super.key});
  

  @override
  State<userProfilePage> createState() => _userProfilePageState();
  
  
}


class _userProfilePageState extends State<userProfilePage> {
   String name="";
  String username="";
  bool isVerified= false;
  String designation="";
  String location="",bio="", link="",profilePic="";

Future<void> userData() async{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? userMail = firebaseAuth.currentUser;
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  List<String>? user= sharedPreferences.getStringList('k');
  print(user);
  setState(() {
    bio=user![5];
designation=user[7];
if(user![0]=="true"){
isVerified=true;
}

link=user[3];
location=user[6];
name=user[4];
profilePic=user[2];
username=userMail!.email!.split('@')[0].toString();

  });
  
}

@override
void initState() {
    // TODO: implement initState
    super.initState();
    userData();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title:  Text(
          username,
          style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
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
                    child: CircleAvatar(radius: 100,backgroundImage: NetworkImage(profilePic),
                    ),
                    ),
                  ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 5, bottom: 0, top: 0),
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                        ),
                         
                        Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, bottom: 0, top: 0),
                               
                            child: Visibility(
                              visible: isVerified,
                              child: Icon(
                                Icons.verified,
                                color: Colors.blue,
                                
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, right: 10, bottom: 0, top: 0),
                      child: Text(
                        designation,
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
                           location,
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
             Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: Text(
                bio,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
             Row(
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
                    link,
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
