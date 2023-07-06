import 'package:flutter/material.dart';

import '../constant/color.dart';

class customeProgressDialogEditPost extends StatefulWidget {
  String selectedLength = "";
  String uploadedLength = "";

  customeProgressDialogEditPost(
      {required this.selectedLength, required this.uploadedLength});

  @override
  State<customeProgressDialogEditPost> createState() =>
      _customeProgressDialogEditPostState();
}

class _customeProgressDialogEditPostState
    extends State<customeProgressDialogEditPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      refreshIndex();
    });
  }

  Future<void> refreshIndex() async {
    Future.delayed(const Duration(seconds: 2), () async {
      int index = int.parse(widget.uploadedLength);
      if (index < int.parse(widget.selectedLength)) {
        index = index + 1;
        setState(() {
          widget.uploadedLength = index.toString();
        });
        refreshIndex();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: trans,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircularProgressIndicator(
            color: Colors.white,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            "Hold on tight while we add your images",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Image Uploaded : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  "${widget.uploadedLength}/${widget.selectedLength}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
