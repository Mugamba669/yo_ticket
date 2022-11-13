// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'reports.dart';
import 'report.dart';

class EditNote extends StatefulWidget {
  DocumentSnapshot docid;
  // ignore: use_key_in_widget_constructors
  EditNote({Key? key, required this.docid}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('Full_Name'));
    subject1 = TextEditingController(text: widget.docid.get('Maths'));
    subject2 = TextEditingController(text: widget.docid.get('Science'));
    subject3 = TextEditingController(text: widget.docid.get('History'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 11, 133),
        actions: [
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
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name.text,
                'Maths': subject1.text,
                'Science': subject2.text,
                'History': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Reports()));
              });
            },
            child: const Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Reports()));
              });
            },
            child: const Text(
              "delete",
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
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: 'name',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject1,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Maths',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject2,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Science',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject3,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'History',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: const Color.fromARGB(255, 0, 11, 133),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => reportt(
                      docid: widget.docid,
                    ),
                  ),
                );
              },
              child: const Text(
                "Make Report",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 251, 251, 251),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
