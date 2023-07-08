import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';
import 'enlargeImage.dart';

class userProfilePost extends StatefulWidget {
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

  userProfilePost(
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
  State<userProfilePost> createState() => _userProfilePostState();
}

class _userProfilePostState extends State<userProfilePost> {
   List<String> postPicList = List.empty();
   
  bool isEnlarges = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postPicList =
          widget.postPic.replaceAll(RegExp(r'[\[\]]'), '').split(', ');
          print(postPicList);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: lightGrey,
                    child: GestureDetector(
                      onLongPress: () {
                      setState(() {
                        isEnlarges = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              enlargeImage(profilePic: postPicList[0]),
                        ),
                      );
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        isEnlarges = false;
                      });
                      Navigator.pop(context);
                    },
                      child: Stack(children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                      height: 450,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                                      ),
                                      items: postPicList.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Transform.scale(
                                scale: 0.1,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 10,
                                ),
                              ),
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
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                          borderRadius: BorderRadius.circular(100)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(Icons.collections_outlined),
                        ),
                      ),
                                      ),
                                    ),
                                  ]),
                    ),
                    ),
                    );
  }
}