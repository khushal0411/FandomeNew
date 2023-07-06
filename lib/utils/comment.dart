import 'package:flutter/material.dart';

import '../constant/color.dart';

class comment extends StatefulWidget {
  final String userName;
  final String comments, profilePic, timeStamp;

  comment(
      {required this.userName,
      required this.comments,
      required this.profilePic,
      required this.timeStamp});

  Map<String, dynamic> toJson() {
    return {
      'userpic': profilePic,
      'username': userName,
      'text': comments,
      'timestamp': timeStamp,
    };
  }

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
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: backgroundColor,
                backgroundImage: NetworkImage(widget.profilePic),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 5),
              child: Text(
                widget.userName,
                style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Text(
            widget.comments,
            style: const TextStyle(color: textColor, fontSize: 13),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Text(
            DateTime.now()
                        .difference(DateTime.parse(widget.timeStamp))
                        .inHours >
                    12
                ? "${DateTime.now().difference(DateTime.parse(widget.timeStamp)).inDays} days ago"
                : "${DateTime.now().difference(DateTime.parse(widget.timeStamp)).inHours} hours ago",
            style: const TextStyle(
                color: Color.fromRGBO(150, 150, 150, 1), fontSize: 13),
          ),
        ),
      ],
    );
  }
}
