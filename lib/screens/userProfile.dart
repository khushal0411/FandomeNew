import 'package:flutter/material.dart';

import '../constant/color.dart';

class userProfilePage extends StatefulWidget {
  const userProfilePage({super.key});

  @override
  State<userProfilePage> createState() => _userProfilePageState();
}

class _userProfilePageState extends State<userProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Row(
          children: [
            Text(
              "angilinamario24",
              style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.verified,
                color: Colors.blue,
              ),
            )
          ],
        ),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.edit_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: textColor,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Center(
                            child: SizedBox(
                          height: 1,
                        )),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35, left: 20, right: 10, bottom: 10),
                              child: Icon(
                                Icons.settings_outlined,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 35, left: 0, right: 10, bottom: 10),
                              child: Text(
                                "Settings",
                                style:
                                    TextStyle(color: textColor, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.menu,
              color: textColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, bottom: 5, top: 10),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: lightGrey),
                    child: Image.asset("assets/images/story.png"),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 5, bottom: 0, top: 0),
                          child: Text(
                            "Angilina Mario",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 10, bottom: 0, top: 0),
                            child: Icon(
                              Icons.verified,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0.0, right: 10, bottom: 0, top: 0),
                      child: Text(
                        "Product Designing",
                        style: TextStyle(
                          fontSize: 13,
                          color: darkGrey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 5.0, bottom: 0, top: 0),
                            child: Icon(
                              Icons.pin_drop_outlined,
                              color: darkGrey,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0.0, right: 10, bottom: 0, top: 0),
                          child: Text(
                            "Sheffield, West London",
                            style: TextStyle(
                              fontSize: 13,
                              color: darkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
              child: Text(
                "Adventure seeker ✨ | Passionate about new ventures 🌟 | Spreading positivity 📸 | Capturing the beauty of the world 🌍Capturing the beauty of the world 🌍",
                style: TextStyle(color: textColor, fontSize: 15),
              ),
            ),
            const Row(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 0.0, bottom: 5.0),
                    child: Icon(
                      Icons.link_rounded,
                      color: Color.fromARGB(255, 38, 102, 154),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 10.0, bottom: 5.0),
                  child: Text(
                    "https://dribbble.com/search/profile",
                    style: TextStyle(
                        color: Color.fromARGB(255, 38, 102, 154),
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Your posts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            GridView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    color: lightGrey,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
