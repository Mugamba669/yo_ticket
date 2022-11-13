import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_page.dart';
import 'Home.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const AuthPage();
          }
        });
  }
}
