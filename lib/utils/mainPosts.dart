import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';

class mainPost extends StatefulWidget {
  final String userName;
  final String location;
  final String caption;
  final String hastags;
  final String imgName;

  mainPost(
      {required this.userName,
      required this.location,
      required this.caption,
      required this.hastags,
      required this.imgName});

  @override
  State<mainPost> createState() => _mainPostState();
}

class _mainPostState extends State<mainPost> {
  final String str1 = "assets/images/";
  final String str2 = ".png";
  final TransformationController _transformationController =
      TransformationController();
  bool isFilled = false;

  void _resetScale() {
    _transformationController.value = Matrix4.identity();
  }

  void toggleIcon() {
    setState(() {
      isFilled = !isFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, bottom: 5, top: 10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: lightGrey),
                  child: Image.asset("assets/images/story.png"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 10, bottom: 0, top: 0),
                    child: Text(
                      widget.userName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 10, bottom: 0, top: 0),
                    child: Text(
                      widget.location,
                      style: const TextStyle(fontSize: 13, color: textColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: const BoxDecoration(color: lightGrey),
              child: GestureDetector(
                onDoubleTap: _resetScale,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: EdgeInsets.all(0.0),
                  minScale: 0.1,
                  maxScale: 5.0,
                  child: Image.asset(
                    'assets/images/${widget.imgName}.png',
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Row(
            children: [
              const SizedBox(
                width: 10,
                height: 50,
              ),
              GestureDetector(
                onTap: toggleIcon,
                child: Icon(
                  isFilled ? Icons.favorite : Icons.favorite_outline,
                  size: 30,
                  color: isFilled ? Colors.red : null,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(
                Icons.comment_outlined,
                size: 30,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("1232 likes",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 10),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: textColor),
                      children: [
                        TextSpan(
                          text: widget.userName,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: widget.caption,
                            style: const TextStyle(fontSize: 15)),
                        TextSpan(
                            text: widget.hastags,
                            style: const TextStyle(
                                color: Color.fromRGBO(100, 134, 185, 1)))
                      ]),
                ),
              )),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("11:34 PM | Tuesday",
                style: TextStyle(
                    fontSize: 14, color: Color.fromRGBO(150, 150, 150, 1))),
          ),
        ],
      ),
    );
  }
}
