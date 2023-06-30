import 'package:flutter/material.dart';

import '../constant/color.dart';

class accountCentreScreen extends StatefulWidget {
  const accountCentreScreen({super.key});

  @override
  State<accountCentreScreen> createState() => _accountCentreScreenState();
}

class _accountCentreScreenState extends State<accountCentreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(" "),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Center(
              child: Text(
                "Account Centre",
                style: TextStyle(color: textColor, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            const Center(
              child: Text(
                "Snapzy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: const Center(
                child: Text(
                  "Manage your account settings from JK technologies centre.",
                  style: TextStyle(color: darkGrey, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: backgroundColor,
                  backgroundImage: AssetImage("assets/images/story.png"),
                  radius: 55,
                ),
              ),
            ),
            const Center(
              child: Text(
                "Anjilina Mario",
                style: TextStyle(color: textColor, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Center(
              child: Text(
                "anjilina_mario24",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: const Center(
                child: Text(
                  "To help keep our community authentic, we’re showing information about accounts in Snapzy.",
                  style: TextStyle(color: darkGrey, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date joined",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      Text(
                        "12-10-2023",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.post_add,
                      size: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total posts",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      Text(
                        "100",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.video_camera_back_outlined,
                      size: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total loops",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor, fontSize: 20),
                      ),
                      Text(
                        "20",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reset password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor, fontSize: 20),
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
