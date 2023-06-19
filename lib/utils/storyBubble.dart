import 'package:flutter/material.dart';

import '../constant/color.dart';

class storyBubble extends StatelessWidget {
  final String text;
  final String imgName;
  final String str1 = "assets/images/";
  final String str2 = ".png";

  storyBubble({required this.imgName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 114,
            decoration: const BoxDecoration(
                color: lightGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Image(
              image: AssetImage(str1 + imgName + str2),
            ),
          ),
          Text(
            text.substring(0, 10),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
