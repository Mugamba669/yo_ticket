import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PTile extends pw.StatelessWidget {
  final String title;
  String subtitle;
  final String trailing;
  IconData? icon;

  PTile({
    this.subtitle = "",
    required this.trailing,
    required this.title,
    this.icon,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
      children: [
        pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(
                text: title,
                style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal),
              ),
              pw.TextSpan(
                text: "\n$subtitle",
                style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.normal),
              )
            ],
          ),
        ),
        pw.Text(
          trailing,
          style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 16,
              fontWeight: pw.FontWeight.normal),
        ),
      ],
    );
  }
}
