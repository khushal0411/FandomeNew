import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';

class addPostPage extends StatefulWidget {
  const addPostPage({super.key});

  @override
  State<addPostPage> createState() => _addPostPageState();
}

class _addPostPageState extends State<addPostPage> {
  XFile? _image;


    Future<void> createPost() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("Postsuser").child(user!.uid.toString())
      .push().set({
      "userProfilePic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
      "userName":user.email?.split('@')[0].toString(),
      "location":"Vadodara, Gujarat, IN",
      "postPic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
      "like":"[joy,Khushal,ali]",
      "comments":"{'joy':'nice','khushal':'good'}",
      "caption":"Beautiful life......",
      "hashtag":"#life #enjoy",
      "timeStamp":DateTime.now().toString()
      });

      databaseReference.child("Posts")
      .push().set({
      "userProfilePic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
      "userName":user.email?.split('@')[0].toString(),
      "location":"Vadodara, Gujarat, IN",
      "postPic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
      "like":"[joy,Khushal,ali]",
      "comments":"{'joy':'nice','khushal':'good'}",
      "caption":"Beautiful life......",
      "hashtag":"#life #enjoy",
      "timeStamp":DateTime.now().toString()
      });

    Fluttertoast.showToast(
        msg: "Profile Created Sucessfully.", toastLength: Toast.LENGTH_SHORT);
  
  }








  Future<void> _openGallery() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _openCamera() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = takenImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text(
            "Add Post",
            style: TextStyle(fontSize: 20, color: textColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "You post have been posted",
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              icon: const Icon(
                Icons.done,
                color: textColor,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
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
                              GestureDetector(
                                onTap: _openGallery,
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 35,
                                          left: 20,
                                          right: 10,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.photo_library_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 35,
                                          left: 0,
                                          right: 10,
                                          bottom: 10),
                                      child: Text(
                                        "Select image from gallery",
                                        style: TextStyle(
                                            color: textColor, fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: _openCamera,
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          left: 20,
                                          right: 10,
                                          bottom: 10),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          left: 0,
                                          right: 10,
                                          bottom: 10),
                                      child: Text(
                                        "Capture image from camera",
                                        style: TextStyle(
                                            color: textColor, fontSize: 18),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: Image.asset(
                      "assets/images/addpost.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  maxLines: 10,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Add your caption",
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
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Add your location",
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
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 100,
                  maxLines: 5,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Add hashtags",
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
            ],
          ),
        ),
      ),
    );
  }
}
