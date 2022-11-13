// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../payments/payment.dart';
import '../../routing/routing.dart';

class CardOption extends StatefulWidget {
  final List<Map<String, dynamic>> ticket;
  final String match;
  final int ticketId;
  const CardOption({
    Key? key,
    required this.ticket,
    required this.match,
    required this.ticketId,
  }) : super(key: key);

  @override
  State<CardOption> createState() => _CardOptionState();
}

class _CardOptionState extends State<CardOption> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              // ignore: prefer_const_literals_to_create_immutables
              children: List.generate(
                widget.ticket.length,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                    // debugPrint("Selected => $selected");
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: (selected + 1) == widget.ticket[index]["id"]
                              ? Colors.orange.shade600
                              : Colors.grey.shade300,
                          width: 2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: ' ' + widget.ticket[index]["name"] + '\n',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: '\nUGX:${widget.ticket[index]["amount"]}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MaterialButton(
              color: Colors.orange[600],
              onPressed: () => routeAnimatePage(
                  context,
                  Payment(
                    ticketId: widget.ticketId,
                    title: widget.ticket[selected]["name"],
                    amount: widget.ticket[selected]["amount"],
                    match: widget.match,
                  )),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text("Proceed to payment"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
