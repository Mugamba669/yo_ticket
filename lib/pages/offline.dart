// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'AppRefresh.dart';
import 'widgets/Space.dart';
import 'widgets/CustomPage.dart';

class Offline extends StatelessWidget {
  const Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomPage(
      child: Column(
        children: [
          Space(
            space: 0.2,
          ),
          Center(
              child: Icon(
            Icons.wifi_off,
            size: size.width * 0.5,
            color: Colors.grey,
          )),
          Space(),
          const Text("You are offline",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
          const Text("Please turn on your internet connection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () => RestartWidget.restartApp(context),
                child: const Text(
                  "Reload",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          // Center(
          //   child: RoundedButton(
          //       text: "Reload",
          //       press: () => RestartWidget.restartApp(context),
          //       color: Colors.red),
          // ),
        ],
      ),
    );
  }
}
