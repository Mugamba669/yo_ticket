import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miic/pages/widgets/CustomPage.dart';

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
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/ball.png"),
        )
      ],
    ));
  }
}
