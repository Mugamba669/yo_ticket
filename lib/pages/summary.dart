import 'package:flutter/material.dart';
import 'package:miic/pages/Print.dart';
import 'package:miic/pages/widgets/DetailCard.dart';
import 'package:miic/routing/routing.dart';
import '../pages/widgets/Space.dart';

class Summary extends StatefulWidget {
  final Map<String, dynamic> data;
  const Summary({Key? key, required this.data}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // ignore: prefer_const_constructors
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.summarize_outlined,
                      color: Colors.white,
                    ),
                    Space(),
                    const Text(
                      "Summary Order",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.093,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Space(),
              const Center(
                child: Text(
                  "Ticket Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Space(),
              DetailCard(
                tiles: [
                  Card(
                    child: ListTile(
                      title: const Text("Ticket No. "),
                      trailing: Text(widget.data["ticket_id"].toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Match "),
                      trailing: Text(widget.data["match"].toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Ticket owner"),
                      trailing: Text(widget.data["customer"]["name"]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Ticket type "),
                      trailing: Text(widget.data["type"]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Email Address "),
                      trailing: Text(widget.data["customer"]["email"]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Amount paid"),
                      trailing: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "${widget.data["currency"]} ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: widget.data["amount"].toString(),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ]),
                      ),
                    ),
                  ),
                  Space(),
                  const Center(
                    child: Text(
                      "Payment Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(),
                  Card(
                    child: ListTile(
                      title: const Text("Payment ref. "),
                      trailing: Text(widget.data["payment_ref"]),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text("Payment date "),
                      trailing: Text(widget.data["date"]),
                    ),
                  ),
                ],
              ),
              Space(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => routeAnimatePage(
                        context,
                        PrintReceipt(
                          data: widget.data,
                          title: "Bruno",
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Print Receipt",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
