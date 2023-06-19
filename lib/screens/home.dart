import 'package:flutter/material.dart';
import 'package:testproj/constant/color.dart';
import 'package:testproj/utils/mainPosts.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Fandome",
          style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
        ),
        actions: [
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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(bottom: 150),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      mainPost(
                        userName: "JensonButton ",
                        location: "ON, Toronto, Canada",
                        caption:
                            "Exploring the vibrant streets and diverse culture of Toronto, Canada! 🇨🇦✨",
                        imgName: "post",
                        hastags:
                            "#TorontoAdventures #CityExploration #CanadianExperience #TravelMemories #TorontoBound #CulturalDiversity #UrbanGetaway",
                      ),
                      mainPost(
                        userName: "MyDoggo ",
                        location: "NYC, City of Dreams",
                        caption:
                            "Unleashing pure joy with my furry friend! 🐶❤️",
                        imgName: "p1",
                        hastags:
                            "##DogLove #PawsomeCompanion #BestBuddy #DogLife #AdorablePooch #PuppyLove #FurBaby #HappyTails",
                      ),
                      mainPost(
                        userName: "Toronto ",
                        location: "ON, Toronto, Canada",
                        caption:
                            "Exploring the vibrant streets and diverse culture of Toronto, Canada! 🇨🇦✨",
                        imgName: "p2",
                        hastags:
                            "#TorontoAdventures #CityExploration #CanadianExperience #TravelMemories #TorontoBound #CulturalDiversity #UrbanGetaway",
                      ),
                      mainPost(
                        userName: "CIA_at_yourhome ",
                        location: "Washinton DC",
                        caption:
                            "Immersed in history and awe-inspiring landmarks in Washington, D.C.! 🏛️✨ Immersed in history and awe-inspiring landmarks in Washington, D.C.! 🏛️✨ Immersed in history and awe-inspiring landmarks in Washington, D.C.! 🏛️✨ Immersed in history and awe-inspiring landmarks in Washington, D.C.! 🏛️✨ ",
                        imgName: "p3",
                        hastags:
                            "#DCExploration #HistoricalWonders #MonumentalCity #CulturalHeritage #CapitalAdventures #IconicLandmarks #DiscoverDC #CityOfHistory",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
