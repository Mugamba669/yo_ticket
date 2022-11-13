// ignore_for_file: unnecessary_const, non_constant_identifier_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'reports.dart';

// ignore: camel_case_types
class AddNote extends StatelessWidget {
  TextEditingController Full_Name = TextEditingController();
  TextEditingController Ticket_Type = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phone_Number = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'Full_Name': Full_Name.text,
                'Ticket_Type': Ticket_Type.text,
                'Email': Email.text,
                'Phone_Number': Phone_Number.text
              }).whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Reports()));
              });
            },
            child: const Text(
              "Print Ticket",
              style: const TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const Reports()));
            },
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: Full_Name,
                decoration: const InputDecoration(
                  hintText: 'full name',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: Ticket_Type,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Tick type',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: Email,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: Phone_Number,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'phone number',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
