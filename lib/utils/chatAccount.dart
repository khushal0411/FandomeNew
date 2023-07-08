import 'package:flutter/material.dart';

import '../constant/color.dart';

class chatAccount extends StatefulWidget {
  String username;
  String email;

  chatAccount({required this.username, required this.email});

  @override
  State<chatAccount> createState() => _chatAccountState();
}

class _chatAccountState extends State<chatAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              backgroundImage: AssetImage("assets/images/story.png"),
              radius: 30,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    widget.username,
                    maxLines: 1,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    widget.email,
                    maxLines: 1,
                    style: TextStyle(
                        color: darkGrey,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
