import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/color.dart';

class emojiDialog extends StatefulWidget {
  const emojiDialog({super.key});

  @override
  State<emojiDialog> createState() => _emojiDialogState();
}

class _emojiDialogState extends State<emojiDialog> {
  List<String> emojiList = ["🤣", "👌", "❤️", "😊", "😂"];
  List<String> selectedEmoji = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: trans,
      elevation: 0,
      child: Center(
        child: Container(
          height: 50,
          width: 177,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
            color: Color.fromARGB(255, 135, 135, 135),
          ),
          child: Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: emojiList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var data = emojiList[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEmoji.add(data);
                      });
                      print("selectedEmoji: " + selectedEmoji.toString());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        data,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
