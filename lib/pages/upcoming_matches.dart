// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:miic/pages/widgets/CardOption.dart';
import 'package:miic/pages/widgets/DragWidget.dart';
import 'package:miic/pages/widgets/Space.dart';
import 'package:miic/pages/widgets/TopWidget.dart';
import 'package:miic/routing/routing.dart';

import '../payments/payment.dart';

class upComingMatches extends StatefulWidget {
  const upComingMatches({Key? key}) : super(key: key);

  @override
  State<upComingMatches> createState() => _upComingMatchesState();
}

class _upComingMatchesState extends State<upComingMatches> {
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
  fetchMatches() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[500],
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            TopWidget(
                headerTitle: "Available Matches",
                subTitle: "Book your tickets early online"),

            // Icon(Icons.receipt_long_rounded)
          ];
        }),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (BuildContext context, int index) => Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/ball.png"),
                ),
                title: Text(teams[index]["team"]),
                subtitle: Text(teams[index]["time"]),
                trailing: TextButton(
                  onPressed: () {
                    // MyHomePage(title: 'hello');
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     behavior: SnackBarBehavior.floating,
                    //     content: Text('Ticked Booked'),
                    //     duration: Duration(seconds: 4),
                    //   ),
                    // );
                    showCategory("Vipers vs KCCA", index);
                    // routeAnimatePage(
                    //   context,
                    //   const Payment(title: 'hello'),
                    // );
                  },
                  child: Text(
                    "Buy Ticket",
                    style: TextStyle(color: Colors.orange[600]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> ticket = [
    {
      "id": 1,
      "name": "Early Bird",
      "amount": 10000,
      "description": "Early Bird Ticket",
      "date": "2021-09-01",
      "time": "12:00:00",
      "venue": "Kampala",
      // "image": "assets/images/earlybird.png"
    },
    {
      "id": 2,
      "name": "Regular",
      "amount": 20000,
      "description": "Regular Ticket",
      "date": "2021-09-01",
      "time": "12:00:00",
      "venue": "Kampala",
      // "image": "assets/images/regular.png"
    },
    {
      "id": 3,
      "name": "VIP",
      "amount": 30000,
      "description": "VIP Ticket",
      "date": "2021-09-01",
      "time": "12:00:00",
      "venue": "Kampala",
      // "image": "assets/images/vip.png"
    },
  ];
  int selected = 0;

  // show bottomSheet
  void showCategory(String data, int index) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  DragWidget(),
                  Space(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Select Ticket Type",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  CardOption(
                    ticket: ticket,
                    match: data,
                    ticketId: index,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
