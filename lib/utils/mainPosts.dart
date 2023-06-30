import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/userProfile.dart';
import 'package:testproj/utils/comment.dart';

// ignore: camel_case_types
class mainPost extends StatefulWidget {
  final String userName;
  final String location;
  final String caption;
  final String hastag;
  final String postPic;
  final String userProfilepic;
  String like;
   String comments;
  final String timeStamp;
  final String index;

  mainPost(
      {required this.userName,
      required this.location,
      required this.caption,
      required this.hastag,
      required this.comments,
      required this.like,
      required this.postPic,
      required this.timeStamp,
      required this.userProfilepic,
      required this.index});

  @override
  State<mainPost> createState() => _mainPostState();
}

class _mainPostState extends State<mainPost> {
  String userComment="";
  final TransformationController _transformationController =
      TransformationController();
  bool isFilled = false;
  String likedData = "";
  bool checkLike = false;
  int _currentImageIndex = 0;
  List<comment> commentList=[];
  List<String> postPicList=List.empty();

  void _resetScale() {
    _transformationController.value = Matrix4.identity();
  }

  void toggleIcon() {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    if (widget.like.isNotEmpty) {
      List<String> likes =
          widget.like.replaceAll(RegExp(r'[\[\]]'), '').split(',');
      print("likes" + likes.length.toString());
      print("original" + widget.like.length.toString());
      if (isFilled == true) {
        likes.remove(user!.email!.split('@')[0].toString());
        if (likes.isEmpty) {
          updateData("");
          checkLike = false;
        } else {
          updateData(likes.toString());
          setState(() {
            checkLike = true;
          });
        }

        setState(() {
          isFilled = !isFilled;
          likedData = likes.toString();
        });
      } else {
        //if(likes.length)
        if (likes.contains(user!.email!.split('@')[0].toString()) == false) {
          likes.add(user!.email!.split('@')[0].toString());
          print(likes);
          updateData(likes.toString());
          setState(() {
            isFilled = true;
            likedData = likes.toString();
            checkLike = true;
          });
        }
      }
    } else {
      List<String> likes = [];
      if (isFilled == true) {
        likes.remove(user!.email!.split('@')[0].toString());
        if (likes.isEmpty) {
          updateData("");
          checkLike = false;
        } else {
          updateData(likes.toString());
          setState(() {
            checkLike = true;
          });
        }
        setState(() {
          isFilled = !isFilled;
          likedData = likes.toString();
        });
      } else {
        //if(likes.length)
        if (likes.contains(user!.email!.split('@')[0].toString()) == false) {
          likes.add(user!.email!.split('@')[0].toString());
          print(likes);
          updateData(likes.toString());
          setState(() {
            isFilled = true;
            likedData = likes.toString();
            checkLike = true;
          });
        }
      }
    }
  }

  Future<void> updateData(String likes) async {
    Map<String, dynamic> updatedData = {"like": likes};
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    // data updation
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    String p = widget.index;

    databaseReference.child('Posts/$p').update(updatedData).then((value) {
      Fluttertoast.showToast(msg: "liked", toastLength: Toast.LENGTH_SHORT);

      //Navigator.push(context, MaterialPageRoute(builder:  (context) => const homeScreen()));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Error Occured while updating Data.",
          toastLength: Toast.LENGTH_SHORT);
    });
    setState(() {
      widget.like = likes;
    });
  }

  Future<void> postComment() async {


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? userProfile = sharedPreferences.getStringList('k');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    comment data= comment(userName: user!.email!.split('@')[0].toString(), comments: userComment, profilePic:userProfile![3] , timeStamp: DateTime.now().toString());
  
    commentList.add(data);
    List<Map<String, dynamic>> jsonList = commentList.map((comment) => comment.toJson()).toList();
    String commentListString = jsonEncode(jsonList);

    Map<String, dynamic> updatedData = {"comments": commentListString};
    // data updation
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    String p = widget.index;

    databaseReference.child('Posts/$p').update(updatedData).then((value) {
      Fluttertoast.showToast(msg: "comment added sucessfully.", toastLength: Toast.LENGTH_SHORT);

      //Navigator.push(context, MaterialPageRoute(builder:  (context) => const homeScreen()));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Error Occured while updating Data.",
          toastLength: Toast.LENGTH_SHORT);
    });
    setState(() {
      widget.comments = commentList.toString();
    });
  }

  Future<void> checkLikes() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    List<String> likes =
        widget.like.replaceAll(RegExp(r'[\[\]]'), '').split(',');
    if (widget.like.isNotEmpty) {
      checkLike = true;
    }
    if (likes.contains(user!.email!.split('@')[0].toString())) {
      isFilled = true;
    } else {
      isFilled = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLikes();
    likedData = widget.like;
//code for comments display
if(widget.comments.isNotEmpty){
  List<dynamic> dataList = jsonDecode(widget.comments);
  List<Map<String, dynamic>> list = dataList.cast<Map<String, dynamic>>();
  //print(dataList);
   List<comment> castedList = dataList.map((entry) {
    return comment(
      profilePic: entry["userpic"],
      userName: entry["username"],
      comments: entry["text"],
      timeStamp: entry["timestamp"],
    );
  }).toList();
  setState(() {
    commentList=castedList;
     
  });
}
setState(() {
  postPicList= widget.postPic .replaceAll(RegExp(r'[\[\]]'), '')
                           .split(',');
});
  
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, bottom: 5, top: 10),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: CircleAvatar(
                      backgroundColor: backgroundColor,
                      backgroundImage: NetworkImage(widget.userProfilepic),
                      radius: 100,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 10, bottom: 0, top: 0),
                    child: Text(
                      widget.userName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 10, bottom: 0, top: 0),
                    child: Text(
                      widget.location,
                      style: const TextStyle(fontSize: 13, color: textColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onDoubleTap:toggleIcon ,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              decoration: const BoxDecoration(color: lightGrey),
              
                child: Stack(children: [
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
                  items: postPicList.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                            "${_currentImageIndex + 1}/${postPicList.length}"),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
                height: 50,
              ),
              GestureDetector(
                onTap: toggleIcon,
                child: Icon(
                  isFilled ? Icons.favorite : Icons.favorite_outline,
                  size: 30,
                  color: isFilled ? Colors.red : null,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: backgroundColor,
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context)
                                .viewInsets
                                .bottom, // Adjust for keyboard height
                          ),
                          height: 470,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Comments",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: darkGrey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: 360,
                                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        comment data = commentList[index];
                        print(index);
                        return data;
                      },
                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 0),
                                      child: TextField(
                                        onChanged: (value) => setState(() {
                userComment = value;
              }),
                                        decoration: InputDecoration(
                                            hintText: "Add your comment"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: postComment,
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.1,
                                      child: Padding(
                                        
                                          padding: const EdgeInsets.only(
                                              left: 0.0, right: 10),
                                          child: Icon(Icons.send_outlined)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.comment_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
          Visibility(
            visible: checkLike,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                  "Liked by " +
                      likedData
                          .replaceAll(RegExp(r'[\[\]]'), '')
                          .split(',')[0] +
                      ((likedData.split(',').length) > 1
                          ? " and " +
                              (likedData.split(',').length - 1).toString() +
                              " others"
                          : ""),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 10),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: textColor),
                      children: [
                        TextSpan(
                          text: widget.userName,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " ", style: const TextStyle(fontSize: 15)),
                        TextSpan(
                            text: widget.caption,
                            style: const TextStyle(fontSize: 15)),
                        TextSpan(
                            text: " ", style: const TextStyle(fontSize: 15)),
                        TextSpan(
                            text: widget.hastag,
                            style: const TextStyle(
                                color: Color.fromRGBO(100, 134, 185, 1)))
                      ]),
                ),
              )),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
                DateTime.now()
                            .difference(DateTime.parse(widget.timeStamp))
                            .inHours >
                        12
                    ? DateTime.now()
                            .difference(DateTime.parse(widget.timeStamp))
                            .inDays
                            .toString() +
                        " days ago"
                    : DateTime.now()
                            .difference(DateTime.parse(widget.timeStamp))
                            .inHours
                            .toString() +
                        " hours ago",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(150, 150, 150, 1))),
          ),
        ],
      ),
    );
  }
}
