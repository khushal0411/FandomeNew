import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/screens/homeScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:testproj/utils/customProgressDialog.dart';

import '../constant/color.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  XFile? _image;

  String name = "";
  String username = "";
  bool isVerified = false;
  String designation = "";
  String location = "",
      bio = "",
      link = "",
      profilePic =
          "https://firebasestorage.googleapis.com/v0/b/fandome-7f9ba.appspot.com/o/profileImages%2Faddprofile.png?alt=media&token=5526aac0-4cef-4204-bc1c-809a694e7ed6",
      email = "",
      gender = "",
      dob = "";
  bool _isLoading = false;

  bool isProgressDialog = true;

  void showCustomProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return customProgressDialog();
      },
    );
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isProgressDialog = false;
      });
      closeCustomProgressDialog();
    });
  }

  void closeCustomProgressDialog() {
    if (isProgressDialog == false) {
      Navigator.pop(context);
    }
  }

  Future<void> userData() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? userMail = firebaseAuth.currentUser;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? user = sharedPreferences.getStringList('k');
    print(user);
    setState(() {
      bio = user![6];
      designation = user[8];
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

  Future<void> updateUserData() async {
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

  Future<void> updateData() async {
    Map<String, dynamic> updatedData = {
      "name": name,
      "age": "92",
      "isVerified": true,
      "link": link,
      "bio": bio,
      "profilePic": profilePic,
      "location": location,
      "designation": designation,
      "dob": dob,
      "gender": gender
    };
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

      databaseReference.child('Users/$p').update(updatedData).then((value) {
        Fluttertoast.showToast(
            msg: "Profile Updated Sucessfully.",
            toastLength: Toast.LENGTH_SHORT);
        updateUserData();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const homeScreen()));

        //Navigator.push(context, MaterialPageRoute(builder:  (context) => const homeScreen()));
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Error Occured while updating Data.",
            toastLength: Toast.LENGTH_SHORT);
      });
    });
  }

  Future<void> _openGallery() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    //print("gallery:"+pickedImage!.path);
    Navigator.pop(context);
    if (pickedImage != null) {
      uploadImageToFirestore(pickedImage!);

      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _openCamera() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(source: ImageSource.camera);
    //print("Camera:"+takenImage!.path);
    Navigator.pop(context);
    if (takenImage != null) {
      uploadImageToFirestore(takenImage!);

      setState(() {
        _image = takenImage;
      });
    }
  }

  Future<void> uploadImageToFirestore(XFile image) async {
    showCustomProgressDialog(context);
    final storage = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("profileImages")
        .child(email + ":ProfilePic");
    final uploadImage = storage.putFile(File(image.path));
    final snapshot = await uploadImage.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      profilePic = downloadUrl;
    });
    closeCustomProgressDialog();
  }

  @override
  void initState() {
    super.initState();
    userData();
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
            "Edit Profile",
            style: TextStyle(fontSize: 20, color: textColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                updateData();
                // Fluttertoast.showToast(
                //   msg: "Your profile have been updated",
                //   toastLength: Toast.LENGTH_SHORT,
                // );
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
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      backgroundImage: NetworkImage(profilePic),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
                child: TextField(
                  controller: TextEditingController(text: email),
                  decoration: const InputDecoration(
                    enabled: false,
                    labelText: "Email",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController(text: username),
                  decoration: const InputDecoration(
                    enabled: false,
                    labelText: "Username",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: name,
                      selection: TextSelection.collapsed(offset: name.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    name = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Name",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: dob,
                      selection: TextSelection.collapsed(offset: dob.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    dob = value;
                  }),
                  decoration: const InputDecoration(
                      fillColor: trans, labelText: "Date of Birth"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: gender,
                      selection: TextSelection.collapsed(offset: gender.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    gender = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Identified As",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: designation,
                      selection:
                          TextSelection.collapsed(offset: designation.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    designation = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Designation / Job",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: link,
                      selection: TextSelection.collapsed(offset: link.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    link = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Add Link",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: location,
                      selection:
                          TextSelection.collapsed(offset: location.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    location = value;
                  }),
                  decoration: const InputDecoration(
                    labelText: "Location",
                    fillColor: trans,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: bio,
                      selection: TextSelection.collapsed(offset: bio.length),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    bio = value;
                  }),
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  maxLines: 7,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: "Bio",
                    fillColor: trans,
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
