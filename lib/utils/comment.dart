import 'package:flutter/material.dart';

import '../constant/color.dart';

class comment extends StatefulWidget {
  final String userName;
  final String comments;

  comment({required this.userName, required this.comments});

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: backgroundColor,
                backgroundImage: AssetImage("assets/images/story.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 5),
              child: Text(
                widget.userName,
                style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Text(
            widget.comments,
            style: TextStyle(color: textColor, fontSize: 13),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Text(
            "11 months ago",
            style: TextStyle(
                color: Color.fromRGBO(150, 150, 150, 1), fontSize: 13),
          ),
        ),
      ],
    );
  }
}
