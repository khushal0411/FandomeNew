import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../utils/chatBubble.dart';

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
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
                        chatBubble(
                          message: "Hey, long time no see! How have you been?",
                          isMe: true,
                          time: "10:00 AM",
                          isReactEmoji: true,
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
