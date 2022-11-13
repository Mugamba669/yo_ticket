// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:miic/pages/widgets/Space.dart';

class TopWidget extends StatefulWidget {
  final String headerTitle;
  final String subTitle;
  Color bgColor;
  double space;
  IconData icon;
  MainAxisAlignment mainAxisAlignment;
  TopWidget({
    Key? key,
    required this.headerTitle,
    required this.subTitle,
    this.space = 0.05,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.bgColor = Colors.orange,
    this.icon = Icons.sports_soccer_rounded,
  }) : super(key: key);

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      stretch: true,
      floating: true,
      snap: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.23,
      pinned: true,
      backgroundColor: widget.bgColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 40, bottom: 20),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: [
            Icon(widget.icon, color: Colors.white, size: 40),
            Space(),
            RichText(
              text: TextSpan(
                text: widget.headerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  TextSpan(
                    text: '\n${widget.subTitle}',
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
