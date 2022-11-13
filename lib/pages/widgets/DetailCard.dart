import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final List<Widget> tiles;
  const DetailCard({Key? key, required this.tiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.663,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(children: tiles),
    );
  }
}
