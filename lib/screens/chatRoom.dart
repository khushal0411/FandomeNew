import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproj/utils/chatResponse.dart';

import '../constant/color.dart';
import '../utils/chatBubble.dart';
import 'homeScreen.dart';

class chatRoom extends StatefulWidget {
  const chatRoom({super.key});

  @override
  State<chatRoom> createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    getChats();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

    Future<void> createChat() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? userProfile = sharedPreferences.getStringList('k');

    // databaseReference
    //     .child("PostsUser")
    //     .child(user!.uid.toString())
    //     .push()
    //     .set({
    //   "userProfilePic": userProfile![3],
    //   "userName": user!.email?.split('@')[0].toString(),
    //   "location": loaction,
    //   "postPic": trimedUrlList,
    //   "like": "",
    //   "comments": "",
    //   "caption": caption,
    //   "hashtag": hashtag,
    //   "timeStamp": DateTime.now().toString(),
    //   "userId":user!.uid.toString()
    // });
    
     Map<String, dynamic> updatedData = {
      "messages": '[{"text":"testing","timeStamp":"2023-07-06 22:15:30.881864","User":"6CixBiZPvLT9uZKOQCqpzHcjfpI3","emoji":""},{"text":"data","timeStamp":"2023-07-06 22:15:30.881864","User":"gmhUYAOL6pOSpdSenBcC6icBIDN2","emoji":""}]'
    };
 databaseReference.child("Chats").child(user!.uid.toString()).child('6CixBiZPvLT9uZKOQCqpzHcjfpI3').push().set({
      'messages':"[{'text':'testing','timeStamp':'2023-07-06 22:15:30.881864','User':'6CixBiZPvLT9uZKOQCqpzHcjfpI3','emoji':''},{'text':'data','timeStamp':'2023-07-06 22:15:30.881864','User':'gmhUYAOL6pOSpdSenBcC6icBIDN2','emoji':''}]"
    });

    databaseReference.child('Chats').child('6CixBiZPvLT9uZKOQCqpzHcjfpI3').child(user!.uid.toString()).update(updatedData).then((value) {
        Fluttertoast.showToast(
            msg: "Profile Updated Sucessfully.",
            toastLength: Toast.LENGTH_SHORT);
        //updateUserData();
        

        //Navigator.push(context, MaterialPageRoute(builder:  (context) => const homeScreen()));
      }).catchError((error) {
        Fluttertoast.showToast(
            msg: "Error Occured while updating Data.",
            toastLength: Toast.LENGTH_SHORT);
      });

    Fluttertoast.showToast(
        msg: "Post Added Sucsessfully", toastLength: Toast.LENGTH_SHORT);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const homeScreen()));
  }


 Future<void> getChats() async {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = firebaseAuth.currentUser;

  databaseReference.child('Chats').child('6CixBiZPvLT9uZKOQCqpzHcjfpI3').child(user!.uid.toString()).once().then((value) async {
    final data = value.snapshot;
    Object? values = data.value;
    Map<dynamic, dynamic>? profileData = values as Map?;

    if (value.snapshot.exists && profileData != null && profileData.isNotEmpty) {
      List<chatResponse> castedList = profileData!.entries.map((entry) {
        String index = entry.key;
        return chatResponse(key: index, message: entry.value);
      }).toList();

      print(castedList[0].message);

      List<dynamic> dataList = jsonDecode(castedList[0].message.toString());
      print(dataList);

      List<Map<String, dynamic>> list = dataList.cast<Map<String, dynamic>>();
      List<chatBubble> castedListChat = list.map((entry) {
        return chatBubble(
          message: entry['text'],
          userId: entry['User'],
          time: entry['timeStamp'],
          isReactEmoji: entry['emoji'],
        );
      }).toList();

      print("chatList: " + castedListChat[0].message);

      

      print(castedList);
    }
  });
}




  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final keyboardHeight = WidgetsBinding.instance!.window.viewInsets.bottom;
    setState(() {
      _keyboardHeight = keyboardHeight;
    });

    if (_keyboardHeight > 0) {
      // Keyboard is shown
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      // Keyboard is hidden
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MyAppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjust for keyboard height
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/chatimg.png"),
                          fit: BoxFit.cover)),
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      children: const [
                        Center(
                          child: Text(
                            "Start your conversation",
                            style: TextStyle(color: darkGrey, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Feel free to chat",
                            style: TextStyle(color: darkGrey, fontSize: 15),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Message"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 10),
                        child: Icon(Icons.send_outlined)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 20,
              backgroundImage: AssetImage("assets/images/story.png"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "Angilina Joli",
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
