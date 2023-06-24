import 'package:flutter/material.dart';

import '../constant/color.dart';

class customProgressDialog extends StatefulWidget {
  const customProgressDialog({super.key});

  @override
  State<customProgressDialog> createState() => _customProgressDialogState();
}

class _customProgressDialogState extends State<customProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: trans,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: const Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Please Wait...",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ]),
      ),
    );
  }
}
