

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/screens/addPost.dart';
import 'package:testproj/screens/editProfile.dart';
import 'package:testproj/utils/enlargeImage.dart';
import 'package:testproj/utils/userProfilePost.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/color.dart';
import '../utils/mainPosts.dart';

class userProfilePage extends StatefulWidget {
  const userProfilePage({super.key});

  @override
  State<userProfilePage> createState() => _userProfilePageState();
}

class _userProfilePageState extends State<userProfilePage> {
  String name = "";
  String username = "";
  bool isVerified = false;
  String designation = "";
  String profilePic="https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Faddprofile.png?alt=media&token=5526aac0-4cef-4204-bc1c-809a694e7ed6";
  String location = "",
      bio = "",
      link = "",
      
      email = "",
      gender = "",
      dob = "";
      List<userProfilePost> post = List.empty();
      List<String> firstPostPic=[];

  bool isEnlarges = false;

  Future<void> userData() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? userMail = firebaseAuth.currentUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? user = sharedPreferences.getStringList('k');
    print(user);
    setState(() {
      bio = user![6];
      designation = user[8].toString();
      if (user![1] == "true") {
        isVerified = true;
      }
      gender = user[0];
      dob = user[2];
      link = user[4];
      location = user[7];
      name = user![5];
      profilePic = user![3];
      username = userMail!.email!.split('@')[0].toString();
      email = userMail.email.toString();
    });
  }

  Future<void> launchURL() async {
    final Uri url = Uri.parse(link);
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(
          msg: "Opening URL: $link", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(
          msg: "Could not open URL", toastLength: Toast.LENGTH_SHORT);
    }
  }
    Future<void> getPostUser() async {
    // data updation
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? userMail = firebaseAuth.currentUser;
    String address= "PostsUser/${userMail?.uid}";
    databaseReference.child(address).once().then((value) async {
      
      if(value.snapshot.exists && value.snapshot!=null  ){
      final data = value.snapshot;
      Object? values = data.value;
      
      Map<dynamic, dynamic>? profileData = values as Map?;

      
      List<userProfilePost> castedList = profileData!.entries.map((entry) {
        String index = entry.key;
        //String key = l1[index];
        Map<dynamic, dynamic> post = entry.value as Map<dynamic, dynamic>;
        return userProfilePost(
          userName: post['userName'],
          location: post['location'],
          caption: post['caption'],
          hastag: post['hashtag'],
          comments: post['comments'].toString(),
          like: post['like'].toString(),
          postPic: post['postPic'].toString(),
          timeStamp: post['timeStamp'],
          userProfilepic: post['userProfilePic'],
          index: index,
        );
      }).toList();

      setState(() {
        post = castedList;
      });
      

      print("postUserProfile");
      print(castedList);
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData();
    getPostUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          username,
          style: const TextStyle(fontFamily: 'pacifico', fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
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
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const addPostPage()));
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
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        isEnlarges = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              enlargeImage(profilePic: profilePic),
                        ),
                      );
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        isEnlarges = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Hero(
                      tag: profilePic,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: lightGrey),
                        child: CircleAvatar(
                      backgroundColor: backgroundColor,
                      radius: 100,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: profilePic,
                          placeholder: (context, url) => Transform.scale(
                            scale: 0.6,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 5, bottom: 0, top: 0),
                            child: Visibility(
                              visible: isVerified,
                              child: const Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 20,
                              ),
                            )),
                        Container(
                          width: 180,
                          height: 25,
                          child: TextField(
                            maxLength: 40,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0),
                              enabled: false,
                              labelText: name,
                              counterText: '',
                              labelStyle: const TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 5, bottom: 0, top: 0),
                            child: Icon(
                              Icons.badge_outlined,
                              color: darkGrey,
                              size: 20,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 5.0, bottom: 0, top: 0),
                          child: Container(
                            width: 170,
                            height: 20,
                            child: TextField(
                              maxLength: 40,
                              decoration: InputDecoration(
                                enabled: false,
                                labelText: designation,
                                counterText: '',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                  color: darkGrey,
                                ),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 5.0, bottom: 0, top: 0),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: darkGrey,
                              size: 20,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 5.0, bottom: 0, top: 0),
                          child: Container(
                            width: 170,
                            height: 20,
                            child: TextField(
                              maxLength: 40,
                              decoration: InputDecoration(
                                enabled: false,
                                labelText: location,
                                counterText: '',
                                labelStyle: const TextStyle(
                                  fontSize: 13,
                                  color: darkGrey,
                                ),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
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
                const Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 0.0, bottom: 5.0),
                    child: Icon(
                      Icons.link_rounded,
                      color: Color.fromARGB(255, 38, 102, 154),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      launchURL();
                    },
                    child: Container(
                      width: 300,
                      height: 20,
                      child: TextField(
                        maxLength: 40,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                          enabled: false,
                          labelText: link,
                          counterText: '',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 38, 102, 154),
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
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
            Visibility(visible:post.isEmpty,child: const Text("No Posts Added Yet")),
            Visibility(
              visible: post.isNotEmpty,
              child: GridView.builder(
                itemCount: post.isEmpty?0:post.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
               itemBuilder: (context, index) {
                          userProfilePost data = post[index];
                          if(data.postPic.isNotEmpty){
                          print(index);
                          return data;}
                        },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
