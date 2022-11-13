// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DragWidget extends StatelessWidget {
  Color? color;
  DragWidget({Key? key, this.color = Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 5,
      width: 50,
      decoration: BoxDecoration(
        color: color!.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
