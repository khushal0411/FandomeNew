import 'package:flutter/material.dart';
import 'package:testproj/screens/chatRoom.dart';

import '../constant/color.dart';
import '../utils/chatAccount.dart';

class chatPage extends StatelessWidget {
  const chatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Chat",
          style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => const chatRoom()));
              },
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  chatAccount(
                      username: "Joy Patel", email: "joypatel242001@gmail.com"),
                  chatAccount(
                      username: "Khsuhal Goyal",
                      email: "khushalgoyal780@gmail.com"),
                  chatAccount(
                      username: "KaranSinh Nakum",
                      email: "karansignnakum123@gmail.com"),
                  chatAccount(
                      username: "Ali Mohammed Haiderali Merchawala",
                      email: "alimohammedhaideralimerchawala@gmail.com"),
                ],
              ),
            ),
          )),
    );
  }
}
