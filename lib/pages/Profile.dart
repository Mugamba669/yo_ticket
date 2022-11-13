import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miic/controllers/UserController.dart';
import 'package:miic/pages/widgets/CustomPage.dart';

import 'widgets/Space.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(
        child: Column(
      // ignore: prefer_const_literals_to_create_immutables
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.2,
            backgroundImage: const AssetImage("assets/ball.png"),
          ),
        ),
        Space(),
        ListTile(
          title: Text("Name"),
          trailing: Text(usrCtrl.uname),
        ),
        ListTile(
          title: Text("Email"),
          trailing: Text("${usrCtrl.auth.currentUser!.email}"),
        ),
        // const ListTile(
        //   title: Text(""),
        //   trailing: Text("Nm"),
        // ),
        Space(),
        OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text("Logout"))
      ],
    ));
  }
}
