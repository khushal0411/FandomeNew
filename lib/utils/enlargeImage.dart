import 'package:flutter/material.dart';

class enlargeImage extends StatelessWidget {
  final String profilePic;

  const enlargeImage({required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: profilePic,
            child: Image.network(profilePic),
          ),
        ),
      ),
    );
  }
}
