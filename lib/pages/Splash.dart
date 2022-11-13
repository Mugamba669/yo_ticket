import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'widgets/CustomPage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    netCheck();
  }

  netCheck() async {
    bool check = await InternetConnectionChecker().hasConnection;

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(check ? "/index" : "/offline");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CustomPage(
        child: Center(
      child: CircularProgressIndicator.adaptive(),
    ));
  }
}
