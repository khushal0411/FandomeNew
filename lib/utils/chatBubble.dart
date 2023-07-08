import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';

import 'emojiDialog.dart';

class chatBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final String time;
  final bool isReactEmoji;

  const chatBubble(
      {required this.message,
      required this.isMe,
      required this.time,
      required this.isReactEmoji});

  @override
  State<chatBubble> createState() => _chatBubbleState();
}

class _chatBubbleState extends State<chatBubble> {
  void showCustomProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return emojiDialog();
      },
    );
  }

  void closeCustomProgressDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showCustomProgressDialog(context);
      },
      child: Row(
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            constraints: BoxConstraints(maxWidth: 300.0),
            decoration: BoxDecoration(
              color: widget.isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: widget.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 15,
                    color: widget.isMe ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    widget.time,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: widget.isMe ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.isReactEmoji,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: backgroundColor,
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              children: [
                                const Center(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 20),
                                  child: Text(
                                    "Emoji Reaction",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                                Center(
                                  child: Container(
                                    color: darkGrey,
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.account_circle_outlined,
                                        size: 40,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Joy Patel",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: textColor, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "❤️",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: widget.isMe
                              ? Color.fromARGB(255, 3, 107, 193)
                              : Color.fromARGB(255, 198, 198, 198),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, right: 5, left: 5, bottom: 5),
                        child: Text(
                          "😂 ❤️",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: widget.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
