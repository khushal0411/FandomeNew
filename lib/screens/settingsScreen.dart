import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/screens/accountCentreScreen.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Settings and privacy"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const accountCentreScreen())));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account centre",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: textColor, fontSize: 20),
                          ),
                          Text(
                            "Password, Security, Personal details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: darkGrey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 0.0, bottom: 10),
              child: Text(
                "Manage your connected experiences and account settings across JK technologies.",
                style: TextStyle(color: darkGrey),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 0),
              child: Text(
                "How to use Snapzy",
                style: TextStyle(color: darkGrey),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add new posts",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit user profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.help_outline,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Help",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 0),
              child: Text(
                "More information",
                style: TextStyle(color: darkGrey),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.info_outline,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Snapzy",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              color: Color.fromARGB(255, 221, 221, 221),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 0),
              child: Text(
                "Why so soon?",
                style: TextStyle(color: darkGrey),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 198, 34, 34),
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: darkGrey,
                    ),
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
