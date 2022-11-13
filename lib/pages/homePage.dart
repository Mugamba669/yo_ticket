// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miic/controllers/UserController.dart';
import 'package:miic/getData/getUserName.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;

  //list to hold document ids
  List<String> docIDs = [];

  //GET THE Document ids
  Future getDocId() async {
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((snapshot) => {
    //           snapshot.docs.forEach((document) {
    //             docIDs.add(document.reference.id);
    //           })
    //         });
  }

  @override
  Widget build(BuildContext context) {
    usrCtrl.getUserName();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Hi ${usrCtrl.uname},",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
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
      body: const Center(),
    );
  }
}
