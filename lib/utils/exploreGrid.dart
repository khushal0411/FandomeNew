import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';

class exploreGrid extends StatelessWidget {
  const exploreGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            color: lightGrey,
          ),
        );
      },
    );
  }
}
