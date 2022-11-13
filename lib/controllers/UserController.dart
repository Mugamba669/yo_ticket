// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final UserController usrCtrl = Get.put(UserController());

class UserController extends GetxController {
  SharedPreferences? prefs;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> store =
      FirebaseFirestore.instance.collection("users");

  String uname = "";
  getUserName() async {
    prefs = await SharedPreferences.getInstance();
    String? userId = prefs?.getString('userId');
    // String? password = prefs.getString('password');
    // try {
    //   UserCredential userCredential = await auth.signInWithEmailAndPassword(
    //       email: email!, password: password!);
    //   if (userCredential.user != null) {
    //     String uid = userCredential.user!.uid;
    //     return store.doc(uid).get();
    //   }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
    var data = await store.doc(userId).get();
    String username = data.data()!['first name'];
    prefs?.setString("username", username);
    uname = username;
    // debugPrint(user.data().toString());
    update();
  }

  setValue(String vkey, String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString(vkey, value);
    update();
  }
}
