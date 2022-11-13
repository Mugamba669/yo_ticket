// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:miic/printWidgets/Barcode.dart';
import 'package:miic/printWidgets/PTile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../printWidgets/PSpace.dart';

class PrintReceipt extends StatelessWidget {
  const PrintReceipt({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        build: (format) => _generatePdf(format, title),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              PSpace(),
              pw.Center(
                child: pw.Text(
                  "Order Summary",
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 22,
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),
              PSpace(),
              PTile(
                  title: "Ticket No.", trailing: data["ticket_id"].toString()),
              PSpace(),
              PTile(
                title: "Match",
                trailing: data["match"],
              ),
              PSpace(),
              PTile(
                title: "Time.",
                trailing: data["type"],
              ),
              PSpace(),
              PTile(
                title: "Ticket Type.",
                trailing: data["type"],
              ),
              PSpace(),
              PTile(title: "Ticket Owner", trailing: data["customer"]["name"]),
              PSpace(),
              PTile(
                  title: "Amount Paid",
                  trailing: "${data['currency']} ${data['amount']}"),
              PTile(title: "Email", trailing: data["customer"]["email"]),
              PSpace(),
              PTile(title: "Payment id", trailing: data["payment_ref"]),
              PSpace(),
              PTile(title: "Date of payement", trailing: data["date"]),
              PSpace(),
              pw.Divider(),
              PSpace(),
              PBarCode(
                text: data.toString(),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
