import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/utils/exploreGrid.dart';

// ignore: camel_case_types, must_be_immutable
class explorePage extends StatelessWidget {
  // explorePage({super.key});

  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  explorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: lightGrey,
            child: const Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: darkGrey,
                ),
                Text(
                  "Search",
                  style: TextStyle(color: darkGrey, fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
      body: const exploreGrid(),
    );
  }
}
