import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void iosRoutePage(BuildContext context, Widget page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

void androidRoutePage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void routePage(BuildContext context, Widget page) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    iosRoutePage(context, page);
  } else {
    androidRoutePage(context, page);
  }
}

void routeAnimatePage(BuildContext context, Widget page) {
  Navigator.pop(context);
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (pageBuilder, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    ),
  );
}
