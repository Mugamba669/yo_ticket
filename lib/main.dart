import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutterwave/flutterwave.dart';
import 'package:miic/pages/Home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/auth_page.dart';
import 'firebase_options.dart';
import 'pages/Splash.dart';
import 'pages/homePage.dart';
import 'pages/index.dart';
import 'pages/offline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? live = true;
  void execute() {
    // Simple check to see if we have Internet

    // setState(() {});
    debugPrint("Is offline $live");
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    execute();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/index': (context) => const Index(),
        '/offline': (context) => const Offline(),
      },
    );
  }
}
