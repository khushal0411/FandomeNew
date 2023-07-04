import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/screens/home.dart';

import '../constant/color.dart';
import 'homeScreen.dart';

class addPostPage extends StatefulWidget {
  const addPostPage({super.key});

  @override
  State<addPostPage> createState() => _addPostPageState();
}

class _addPostPageState extends State<addPostPage> {
  XFile? _image;
  List<XFile?> imageList = [];
  List<String> urlList = [];
  String caption = "", loaction = "", hashtag = "";
  int uploadCounter = 0;
  String trimedUrlList = "";
  int _currentImageIndex = 0;

  Future<void> createPost() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? userProfile = sharedPreferences.getStringList('k');
    // databaseReference.child("Postsuser").child(user!.uid.toString())
    //   .push().set({
    //   "userProfilePic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
    //   "userName":user.email?.split('@')[0].toString(),
    //   "location":"Vadodara, Gujarat, IN",
    //   "postPic":"https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Ftest%40gmail.com%3AProfilePic?alt=media&token=936c1871-14ce-4ad5-9175-edf1c1852325",
    //   "like":"[joy,Khushal,ali]",
    //   "comments":"{'joy':'nice','khushal':'good'}",
    //   "caption":"Beautiful life......",
    //   "hashtag":"#life #enjoy",
    //   "timeStamp":DateTime.now().toString()
    //   });

    databaseReference.child("Posts").push().set({
      "userProfilePic": userProfile![3],
      "userName": user!.email?.split('@')[0].toString(),
      "location": loaction,
      "postPic": trimedUrlList,
      "like": "",
      "comments": "",
      "caption": caption,
      "hashtag": hashtag,
      "timeStamp": DateTime.now().toString()
    });

    Fluttertoast.showToast(
        msg: "Post Added Sucsessfully", toastLength: Toast.LENGTH_SHORT);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const homeScreen()));
  }

  Future<void> uploadDataAndPost() async {
    for (XFile? i in imageList) {
      uploadImageToFirestore(i!);
      print(i);
    }
  }

  Future<void> uploadImageToFirestore(XFile image) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    final storage = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("postImages")
        .child("ProfilePic:${user!.uid}/${DateTime.now().microsecond}");
    final uploadImage = storage.putFile(File(image.path));
    final snapshot = await uploadImage.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      urlList.add(downloadUrl);
      print(downloadUrl);
      uploadCounter = uploadCounter + 1;
    });
    if (uploadCounter == imageList.length) {
      trimedUrlList = urlList.join(', ');
      print('trimmed' + trimedUrlList);
      createPost();
    }
  }

  Future<void> _openGallery() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickMultiImage();
    setState(() {
      imageList = pickedImage;
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = takenImage;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                uploadDataAndPost();
                Fluttertoast.showToast(
                  msg: "Your post have been posted",
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
              Visibility(
                visible: imageList.isEmpty,
                child: Center(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
              ),
              Visibility(
                visible: imageList.isNotEmpty,
                child: Center(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                        height: 450,
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: lightGrey),
                        child: Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 450,
                                enableInfiniteScroll: false,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentImageIndex = index;
                                  });
                                },
                                enlargeCenterPage: false,
                                scrollDirection: Axis.horizontal,
                                autoPlay: false,
                              ),
                              items: imageList.map(
                                (assets) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.file(
                                          File(assets!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 50,
                                height: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                        "${_currentImageIndex + 1}/${imageList.length}"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  maxLines: 10,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) => setState(() {
                    caption = value;
                  }),
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
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  onChanged: (value) => setState(() {
                    loaction = value;
                  }),
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
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLength: 100,
                  maxLines: 5,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) => setState(() {
                    hashtag = value;
                  }),
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
