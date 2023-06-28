import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/addPost.dart';
import 'package:testproj/screens/signin.dart';
import 'package:testproj/utils/mainPosts.dart';
import 'package:testproj/utils/mainPosts.dart';

import '../utils/mainPosts.dart';
import '../utils/mainPosts.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  List<mainPost> post = List.empty();
  Future<void> pushData() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    // data updation
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child("Users")
        .child(user!.uid.toString())
        .once()
        .then((value) {
      final data = value.snapshot;
      Object? values = data.value;
      Map<dynamic, dynamic>? personMap = values as Map?;
      print(personMap!.keys.first.toString());
      String p = user.uid.toString() + "/" + personMap!.keys.first.toString();

      databaseReference.child('Users/$p').once().then((value) async {
        final data = value.snapshot;
        Object? values = data.value;
        Map<dynamic, dynamic>? profileData = values as Map?;
        List l = profileData!.values.toList();
        print(l.toString());
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        List<String> stringList = l.map((item) => item.toString()).toList();
        print(stringList);
        sharedPreferences.setStringList("k", stringList);
      });
    });
  }

  Future<void> getPost() async {
    // data updation
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    databaseReference.child('Posts').once().then((value) async {
      final data = value.snapshot;
      Object? values = data.value;
      Map<dynamic, dynamic>? profileData = values as Map?;

      List<mainPost> castedList = profileData!.entries.map((entry) {
        String index = entry.key;
        //String key = l1[index];
        Map<dynamic, dynamic> post = entry.value as Map<dynamic, dynamic>;
        return mainPost(
          userName: post['userName'],
          location: post['location'],
          caption: post['caption'],
          hastag: post['hashtag'],
          comments: post['comments'].toString(),
          like: post['like'].toString(),
          postPic: post['postPic'],
          timeStamp: post['timeStamp'],
          userProfilepic: post['userProfilePic'],
          index: index,
        );
      }).toList();

      setState(() {
        post = castedList;
      });

      print(castedList);
    });
  }

  Future<void> refreshPage() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      getPost();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost();
    pushData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Fandome",
          style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const addPostPage()),
              );
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: backgroundColor,
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 5,
                            width: 80,
                            decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: lightGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        )),
                        const Row(
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
                        GestureDetector(
                          onTap: () async {
                            try {
                              await firebaseAuth.signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const signIn()),
                              );
                              Fluttertoast.showToast(
                                  msg: "User Signed Out Successfully.",
                                  toastLength: Toast.LENGTH_SHORT);
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "Error signing out -$e",
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 20, right: 10, bottom: 10),
                                child: Icon(
                                  Icons.logout_outlined,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 0, right: 10, bottom: 10),
                                child: Text(
                                  "Log Out",
                                  style:
                                      TextStyle(color: textColor, fontSize: 18),
                                ),
                              )
                            ],
                          ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(bottom: 140),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: RefreshIndicator(
                    onRefresh: refreshPage,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: post.length,
                      itemBuilder: (context, index) {
                        mainPost data = post[index];
                        print(index);
                        return data;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
