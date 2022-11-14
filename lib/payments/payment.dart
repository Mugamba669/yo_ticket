// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:miic/controllers/UserController.dart';
import 'package:miic/pages/summary.dart';
import 'package:miic/routing/routing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Payment extends StatefulWidget {
  const Payment(
      {Key? key,
      required this.title,
      required this.amount,
      required this.match,
      required this.ticketId})
      : super(key: key);

  final String title;
  final String match;
  final int amount;
  final int ticketId;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";
  String uuid = const Uuid().v1();
  bool isTestMode = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;
    amountController.text = "${widget.amount}";
    emailController.text = usrCtrl.auth.currentUser?.email ?? "";
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.15,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Payment for",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600)),
                TextSpan(
                    text: " ${widget.title}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w200)),
              ])),
            ),
          ),
        ],
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          // margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: const Text("Ticket Type"),
                    trailing: Text(widget.title),
                  ),
                  ListTile(
                    title: const Text("Amount to pay"),
                    trailing: Text(widget.amount.toString()),
                  ),
                  ListTile(
                    title: const Text("Currency"),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextFormField(
                        controller: currencyController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        readOnly: true,
                        onTap: _openBottomSheet,
                        decoration: const InputDecoration(
                          hintText: "Currency",
                        ),
                        validator: (value) =>
                            value!.isNotEmpty ? null : "Currency is required",
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Email Address"),
                    trailing: SizedBox(
                      width: 205,
                      height: 100,
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Email address",
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: ElevatedButton(
                      onPressed: _onPressed,
                      child: const Text(
                        "Make Payment",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    final Customer customer = Customer(
        name: "${pres.getString("username")} ${pres.getString("lastname")}",
        phoneNumber: phoneNumberController.text,
        email: emailController.text);

    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: "FLWPUBK_TEST-ef7bd4f1bd8a112740eb300dd20083d4-X",
      // encryptionKey: "FLWSECK_TESTcc6563bff662".trim(),
      currency: selectedCurrency,
      redirectUrl: 'https://flutterwave.com',
      txRef: uuid,
      amount: amountController.text.toString().trim(),
      customer: customer,
      paymentOptions: "card, barter, bank transfer, ussd",
      customization: Customization(
          title: "Purchase Ticket",
          description:
              "You are booking a ticket for the match between Vipers and KCCA FC"),
      isTestMode: true,
    );
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      if (response.success == true) {
        Map<String, dynamic> data = {
          "tx_ref": uuid.trimLeft(),
          "type": widget.title,
          "ticket_id": widget.ticketId,
          "time": "", "match": widget.match,
          "date": DateTime.now().toLocal().toString(),
          "amount": widget.amount,
          "currency": currencyController.text,
          "payment_ref": response.transactionId,
          // "payment_options": "card",
          "customer": {
            "email": usrCtrl.auth.currentUser?.email,
            "phone": phoneNumberController.text,
            "name": usrCtrl.uname
          },
        };
        showLoading("Transaction completed successfully.\n ${response.status}");
        routeAnimatePage(context, Summary(data: data));

        debugPrint("${response.toJson()}");
      } else {
        showLoading("Transaction failed!!! \n ${response.status}");
      }
      // showLoading(response.success.toString());
    } else {
      showLoading("No Response!");
    }
  }

  String getPublicKey() {
    if (isTestMode) return "FLWPUBK_TEST-f3380ee93ac2cacd8047c38c85c2e00f-X";
    return "FLWPUBK_TEST-16029d185fd2edb8519bc0782388a98e-X";
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              width: double.infinity,
              height: 150,
              child: Text(message),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay"),
              ),
            ]);
      },
    );
  }
}
