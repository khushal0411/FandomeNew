import 'package:flutter/material.dart';

import '../constant/color.dart';

class storyPage extends StatelessWidget {
  const storyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              "Fandome",
              style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: 75,
                height: 30,
                decoration: const BoxDecoration(
                  color: companyColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: const Center(child: Text("Story")),
              ),
            )
          ],
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.menu,
              color: textColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/images/story.png",
                    width: 70,
                    height: 70,
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Story",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Tap to add story",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(150, 150, 150, 1)),
                    )
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "View stories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ms. MarvokChain",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "12:22 | Monday",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/story.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Story",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Tap to add story",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(150, 150, 150, 1)),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
