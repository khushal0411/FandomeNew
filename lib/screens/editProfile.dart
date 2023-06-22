import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/screens/homeScreen.dart';
import 'package:testproj/screens/userProfile.dart';

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
  String location = "", bio = "", link = "", profilePic = "",email="",gender="",dob="";


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
      gender=user[0];
      dob=user[2];
      link = user[4];
      location = user[7];
      name = user![5];
      profilePic = user![3];
      username = userMail!.email!.split('@')[0].toString();
      email=userMail.email.toString();
    
    });
  }

Future<void> updateUserData() async{
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

});});



  }
  Future<void> updateData() async {
  Map<String, dynamic> updatedData = {
    "name":name,
    "age": "92",
    "isVerified": true,
    "link": link,
    "bio":
        bio,
    "profilePic": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
    "location": location,
    "designation": designation,
    "dob": dob,
    "gender":gender
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

databaseReference.child('Users/$p').update(updatedData).then((value) {
    Fluttertoast.showToast(msg: "Profile Updated Sucessfully.",toastLength: Toast.LENGTH_SHORT);
    updateUserData();
    Navigator.of(context).pop();
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const homeScreen()));
  
    //Navigator.push(context, MaterialPageRoute(builder:  (context) => const homeScreen()));
  }).catchError((error) {
    Fluttertoast.showToast(msg: "Error Occured while updating Data.",toastLength: Toast.LENGTH_SHORT);
  });

});

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
  void initState() {
   
    super.initState();
    userData();
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
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: Image.asset("assets/images/addprofile.png"),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
                child: TextField(
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: email,
                    filled: true,
                    fillColor: trans,
                    disabledBorder: OutlineInputBorder(
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
                  decoration: InputDecoration(
                    enabled: false,
                    hintText: username,
                    filled: true,
                    fillColor: trans,
                    disabledBorder: OutlineInputBorder(
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
                child: TextField( onChanged: (value) => setState(() {
                  name = value;
                }),
              
                  decoration: InputDecoration(
                    hintText: name,
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
                  dob = value;
                }),
                  decoration: InputDecoration(
                    hintText:dob,
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
                  gender= value;
                }),
                  decoration: InputDecoration(
                    hintText: gender,
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
                 designation = value;
                }),
                  decoration: InputDecoration(
                    hintText: designation,
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
                  link = value;
                }),
                  decoration: InputDecoration(
                    hintText: link,
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
                  location = value;
                }),
                  decoration: InputDecoration(
                    hintText: location,
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
                  bio = value;
                }),
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  maxLines: 7,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: bio,
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
