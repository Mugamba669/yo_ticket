import 'package:flutter/material.dart';

class CustomPage extends StatefulWidget {
  final Widget child;
  const CustomPage({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            child: Container(),
          ),
          widget.child,
        ],
      ),
    );
  }
}
