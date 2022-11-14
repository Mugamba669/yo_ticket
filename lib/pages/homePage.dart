// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miic/controllers/UserController.dart';
import 'package:miic/getData/getUserName.dart';
import 'package:miic/pages/widgets/Space.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username = "";
  @override
  initState() {
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;

  //list to hold document ids
  List<Map<String, dynamic>> leagues = [
    {
      "league_key": "195",
      "league_name": "Bundesliga",
      "country_key": "51",
      "country_name": "Germany",
      "league_logo":
          "https://allsportsapi.com/logo/logo_leagues/195_bundesliga.png"
    },
    {
      "league_key": "176",
      "league_name": "Ligue 1",
      "country_key": "46",
      "country_name": "France",
      "league_logo":
          "https://allsportsapi.com/logo/logo_leagues/176_ligue-1.png"
    },
    {
      "league_key": "148",
      "league_name": "Premier League",
      "country_key": "41",
      "country_name": "England",
      "league_logo": "https://allsportsapi.com/logo/logo_leagues/512_1.-lig.png"
    }
  ];
  List<Map<String, dynamic>> teams = [
    {
      "team": "KCCA Vs Vipers",
      "time": "1:00- 2:30pm",
      "date": "12/10/2022",
      "venue": "Namboole Stadium",
      "image": ""
    },
    {
      "team": "Jnja FC Vs Bunamwaya FC",
      "time": "3:00 - 4:30pm",
      "date": "12/12/2022",
      "venue": "Namboole Stadium",
      "image": ""
    },
    {
      "team": "Mbale FC Vs Brighton FC",
      "time": "12:00pm",
      "date": "12/12/2021",
      "venue": "Namboole Stadium",
      "image": ""
    }
  ];

  //GET THE Document ids
  getDocId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    // usrCtrl.getUserName();
    getDocId();

    return Scaffold(
      appBar: AppBar(
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Hi $username,",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
          ]),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Available Leagues",
              style: TextStyle(fontSize: 20),
            ),
          ),
          CarouselSlider(
            items: List.generate(
              leagues.length,
              (index) => Card(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      image: NetworkImage(leagues[index]["league_logo"]),
                    ),
                  ),
                ),
              ),
            ),
            options: CarouselOptions(autoPlay: true),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Up coming matches",
              style: TextStyle(fontSize: 20),
            ),
          ),
          CarouselSlider(
            items: List.generate(
              teams.length,
              (index) => Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 3,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/ball.png",
                        width: 300,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Space(),
                      Text(
                        teams[index]["team"],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            options: CarouselOptions(),
          ),
        ],
      ),
    );
  }
}
