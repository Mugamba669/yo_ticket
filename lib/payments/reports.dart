import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/widgets/TopWidget.dart';
import 'addnote.dart';
import 'editnote.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('report').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[500],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange[500],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AddNote()));
        },
        label: const Text("Add Report"),
        icon: const Icon(
          Icons.add,
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 0, 11, 133),
      //   title: const Text('Booking Ticket'),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            TopWidget(headerTitle: "Reports", subTitle: "View your reports"),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: StreamBuilder(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditNote(docid: snapshot.data!.docs[index]),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 3,
                              right: 3,
                            ),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              title: Text(
                                snapshot
                                    .data!.docChanges[index].doc['Full_Name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
